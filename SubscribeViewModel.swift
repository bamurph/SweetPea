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
                let feed = Feed(from: n)
                store.addSubscription(title: n.title!, summary: n.description!, xmlUrl: n.link!, htmlUrl: n.link!, feed: feed)

            }).addDisposableTo(disposeBag)

    }


}



