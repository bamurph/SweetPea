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



class RootViewModel {



    // MARK: - Dependencies
    private let disposeBag = DisposeBag()
    private let rssService = RSSService()


    // MARK: - Model
    let episodes: Observable<[Episode]>
    let feeds: Observable<[Feed]>
    var notificationToken: NotificationToken?


    init() {

        feeds = store().feeds.asObservableArray()
        episodes = store().episodes.asObservableArray()


        refreshFeeds().subscribe(onNext: {n in
            switch n {
            case true: print("refreshing")
            case false: print("no refreshing")
            }
        }).addDisposableTo(disposeBag)

    }


    /// TODO: Replace this after we figure out Refresh/Caching story
    func refreshFeeds() -> Observable<Bool> {
        return Observable.create { observer in
            observer.onNext(false)
            let refresher = Observable.just(1)
                .observeOn(bgScheduler)
                .subscribe(onCompleted: {
                    let bgStore = store()
                    bgStore.feeds.forEach {
                        $0 |> self.rssService.refresh
                        observer.onNext(true)
                    }
                    observer.onNext(false)
                    observer.onCompleted()
                })

            return refresher
        }
    }
    
    
}



