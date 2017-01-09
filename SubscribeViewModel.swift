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

    /// Each new element fires a new attempt to fetch a podcast.
    let urlText = Variable<String>("")

    init() {
        feed = urlText.asObservable()
            .debounce(0.25, scheduler: MainScheduler.instance)
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
            .map {
                if case .success(let val) = $0 {
                    return val.title ?? "no title!?"
                } else {
                    return ""
                }

        }
    }
}

