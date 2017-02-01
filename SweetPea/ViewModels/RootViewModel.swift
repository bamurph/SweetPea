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
    let episodes: Observable<Episode>
    let feeds: Observable<Feed>


    init() {
        feeds = Observable.from(store.feeds |> Array.init)
        episodes = Observable.from(store.episodes |> Array.init)


        /// Refresh feeds on launch
        //defer { _ = refresh(oldFeeds: feeds) }
    }


    func refresh(oldFeeds: Observable<Feed>) -> Disposable {
        return oldFeeds
            .subscribe(onNext: {n in
                self.rssService.refresh(n)
            }, onCompleted: {c in
                print("Feeds are refreshed!")
            })
    }
}
