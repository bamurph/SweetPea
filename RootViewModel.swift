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
    var notificationToken: NotificationToken?


    init() {

        feeds = Observable.from(store.objects(Feed.self))
        //episodes = Observable.from(store.objects(Episode.self))


        episodes =
            Observable.from(store.objects(Episode.self))
                .do(onNext: {n in
                    print(n.title)
                })
        //.scan([Episode]()) { acc, val in
        //return acc + [val] }


        /// Refresh feeds on launch
        _ = refresh(oldFeeds: feeds)
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
