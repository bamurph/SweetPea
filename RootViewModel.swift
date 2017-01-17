//
//  RootViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/16/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class RootViewModel {

    // MARK: - Dependencies
    private let disposeBag = DisposeBag()
    private let rssService = RSSService()

    // MARK: - Model
    let episodes: Observable<[Episode]>

    let feeds: Observable<[Feed]>


    init() {
        feeds = Observable.from(store.feeds).map { Array($0) }
        episodes = Observable.from(store.episodes).map { Array($0) }

        // Fetch episodes for feed
        // TODO: - Extract this to model / viewmodel / service?
        _ = feeds
            .debug()
            .map { Observable.from($0) }
            .concat()
            .map { self.rssService.performFetch($0.link) }
            .concat()
            .subscribe(onNext: {n in
                switch n {
                case .failure(let err):
                    print(err)
                case .success(let val):
                    let feed = Feed(from: val)
                    store.addFeed(feed)
                }
            })


    }

    // MARK: - Refresh Episodes

}
