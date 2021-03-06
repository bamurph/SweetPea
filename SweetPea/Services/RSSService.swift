//
//  RSSService.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/14/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import FeedKit
import RxSwift
import Lepton
import RealmSwift

typealias RSSUrl = URL

protocol RSSProtocol {
    func fetch(url: RSSUrl) -> Observable<RSSFeed>

}

enum RSSServiceError: Error {
    case atomSyntax
    case nilUrl
    case badUrl
}



/// Bare-Bones RSS Service
struct RSSService: RSSProtocol {


    func fetch(url: RSSUrl) -> Observable<RSSFeed> {
        return Observable.create { observer in

            guard let data = NSData(contentsOf: url) as? Data else {
                observer.onError(RSSServiceError.badUrl)
                return Disposables.create()
            }

            FeedParser(data: data).parse { result in

                switch result {
                case .rss(let rssFeed):
                    observer.onNext(rssFeed)
                    observer.onCompleted()
                case .atom:
                    observer.onError(RSSServiceError.atomSyntax)
                case .failure:
                    observer.onError(RSSServiceError.badUrl)
                }
            }
            return Disposables.create()
        }
    }

    func rssFeeds(for urls: [URL]) -> Observable<RSSFeed> {
        return Observable.from(urls)
            .map { RSSService().fetch(url: $0) }
            .merge()
    }

    func performFetch(_ url: URL) -> Observable<Result<RSSFeed>> {
        return Observable.create { observer in
            self.fetch(url: url)
                .subscribe(onNext: { n in
                    observer.onNext(Result.success(n))
                }, onError: { e in
                    observer.onNext(Result.failure(e))
                })
        }
    }

    func performFetch(_ path: String) -> Observable<Result<RSSFeed>> {
        guard let url = URL(string: path) else { return Observable.error(RSSServiceError.badUrl) }
        return performFetch(url)
    }

    func refresh(_ feed: Feed) {
        let bgs = SerialDispatchQueueScheduler(qos: .background)
        let feedRef = ThreadSafeReference(to: feed)
        
        let feed$ = Observable.from(feedRef)
            .observeOn(bgs)
            .map { store().resolve($0) }
            .map { $0?.subscription.first?.xmlUrl }
            .filter { $0 != nil }
            .flatMap { self.performFetch($0!) }
            .subscribeOn(bgs)


        _ = feed$.subscribe(onNext: { n in

            switch n {
            case .success(let v):
                let feed = Feed(from: v)
                store().refresh(feed)
                store().addFeedImage(feed)
                print(feed.imageLocalUrl)
            case .failure(let e):
                print(e)
            }

        })

    }

 
}




