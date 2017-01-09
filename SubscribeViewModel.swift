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
    private let service = RSSService()

    // MARK: - Model
    private let feed: Observable<Result<RSSFeed>>

    let podcastTitle: Observable<String>

    /// Each new element fires a new attempt to fetch a podcast.
    let podcastUrl = Variable<String>("")

    init() {
        feed = podcastUrl.asObservable()
            .debounce(0.25, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { URL(string: $0) }
            .flatMapLatest { url -> Observable<Result<RSSFeed>> in
                guard url != nil else {
                    return Observable.empty()
                }

                return self.service.performFetch(url!)
            }
            .shareReplay(1)

        podcastTitle = feed
            .map { $0 }
    
    
}

