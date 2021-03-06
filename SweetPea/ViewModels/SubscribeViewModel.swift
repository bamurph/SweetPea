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

protocol SubscribeViewModelDelegate: class {
    func didAddSubscription(viewModel: SubscribeViewModel)
}

class SubscribeViewModel {

    // MARK: - Dependencies
    private let disposeBag = DisposeBag()
    var coordinatorDelegate: SubscribeViewModelDelegate?

    // MARK: - Model
    private let feed: Observable<(String, Result<RSSFeed>)>

    let podcastTitle: Observable<String>
    let podcastDescription: Observable<String>


    /// Inputs
    /// Each new element fires a new attempt to fetch a podcast.
    let urlText = Variable<String>("")

    /// Each save action (a tap on subscribe button, etc) will be used to trigger subscribe
    let addSubscription = Variable<Void>()


    /// Convenience function for refreshing feed with URL via RSSService
    public func refresh(url: URL) {
        urlText.value = url.absoluteString
        addSubscription.value = ()
    }


    init() {
        feed = urlText.asObservable()
            .distinctUntilChanged()
            .map { URL(string: $0) }
            .flatMapLatest { url -> Observable<(String, Result<RSSFeed>)> in
                guard url != nil else {
                    return Observable.empty()
                }

                return RSSService().performFetch(url!)
                    .map { (url!.absoluteString, $0) }
            }
            .shareReplay(1)

        podcastTitle = feed
            .map { try? $0.1.unwrap() }
            .map { $0?.title ?? "" }


        podcastDescription = feed
            .map { try? $0.1.unwrap() }
            .map { $0?.description ?? ""}

        addSubscription.asObservable()
            .debug()
            .withLatestFrom(feed)
            .map { ($0.0, try? $0.1.unwrap()) }
            .filter { $0.1 != nil }
            .map { ($0.0, $0.1!) }
            .subscribe(onNext: {n in
                let feed = Feed(from: n.1)
                store().addSubscription(title: feed.title, summary: feed.feedDescription, xmlUrl: n.0, htmlUrl: feed.link, feed: feed)
//                store().addFeed(feed)
                store().addFeedImage(feed)
                self.coordinatorDelegate?.didAddSubscription(viewModel: self)
            }).addDisposableTo(disposeBag)

    }



}



