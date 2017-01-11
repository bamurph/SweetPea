//
//  SubscribeViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/9/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import FeedKit

class SubscribeViewModel {

    // MARK: - Dependencies
    private let disposeBag = DisposeBag()

    // MARK: - Model
    private let feed: Observable<Result<RSSFeed>>

    let podcastTitle: Observable<String>
    let podcastDescription: Observable<String>


    /// Inputs
    /// Each new element fires a new attempt to fetch a podcast.
    let urlText = Variable<String>("")

    /// Each save action (a tap on subscribe button, etc) will be used to trigger subscribe
    let addSubscription = Variable<Void>()


    init() {
        feed = urlText.asObservable()
            .distinctUntilChanged()
            .map { URL(string: $0) }
            .flatMapLatest { url -> Observable<Result<RSSFeed>> in
                guard url != nil else {
                    return Observable.empty()
                }

                return RSSService().performFetch(url!)
            }
            .shareReplay(1)

        podcastTitle = feed
            .map { try? $0.unwrap() }
            .map { $0?.title ?? "" }


        podcastDescription = feed
            .map { try? $0.unwrap() }
            .map { $0?.description ?? ""}

        addSubscription.asObservable().withLatestFrom(feed)
            .map { try? $0.unwrap() }
            .filter { $0 != nil }
            .map { $0! }
            .subscribe(onNext: {n in
                print(n)
                let feed = Feed()
                feed.title = n.title!
                feed.link = n.link!
                feed.feedDescription = n.description
                feed.language = n.language
                feed.copyright = n.copyright
                feed.managingEditor = n.managingEditor
                feed.webMaster = n.webMaster
                feed.pubDate = n.pubDate
                feed.lastBuildDate = n.lastBuildDate
                feed.imageUrl = n.image?.link
                feed.categories = feed.stringsFrom(categories: n.categories) ?? [""]

                store.addSubscription(title: n.title!, summary: n.description!, xmlUrl: n.link!, htmlUrl: n.link!, feed: feed)

            })



    }

    func subscribe() {
        //        let save: Observable<
        //        let addSub = feed
        //            .subscribe(onNext: { n in
        //                print(n)
        //                switch n {
        //                case .success(let sub):
        //                    let feed = Feed()
        //                    feed.title = sub.title!
        //                    feed.link = sub.link!
        //                    feed.feedDescription = sub.description
        //                    feed.language = sub.language
        //                    feed.copyright = sub.copyright
        //                    feed.managingEditor = sub.managingEditor
        //                    feed.webMaster = sub.webMaster
        //                    feed.pubDate = sub.pubDate
        //                    feed.lastBuildDate = sub.lastBuildDate
        //                    feed.imageUrl = sub.image?.link
        //                    feed.categories = feed.stringsFrom(categories: sub.categories)!
        //                    store.addFeed(feed)
        //                    print(feed)
        //                    store.addSubscription(title: sub.title!, summary: sub.description!, xmlUrl: sub.link!, htmlUrl: sub.link!, feed: feed)
        //                case .failure(let err):
        //                    print(err)
        //                }
        //            })
        
    }
    
}

