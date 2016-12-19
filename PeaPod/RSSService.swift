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

enum RSSServiceErrors: Error {
    case atomSyntax
    case nilUrl
    case badUrl
}

/// Bare-Bones RSS Service
struct RSSService: RSSProtocol {



    func fetch(url: RSSUrl) -> Observable<RSSFeed> {
        return Observable.create { observer in

            guard let data = NSData(contentsOf: url) as? Data else {
                observer.onError(RSSServiceErrors.badUrl)
                return Disposables.create()
            }

            FeedParser(data: data).parse { result in
                switch result {
                case .rss(let rssFeed):
                    observer.onNext(rssFeed)
                    observer.onCompleted()
                case .atom:
                    observer.onError(RSSServiceErrors.atomSyntax)
                case .failure(let error):
                    observer.onError(error)
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
}




