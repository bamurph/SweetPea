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

    // MARK: - Model
    private let episodes: Observable<[(title: String, feedTitle: String?, date: Date?)]>

    init() {
        episodes = Observable.arrayFrom(store.objects(Episode.self))
            .map { $0.map { ($0.title, $0.feed?.title, $0.pubDate) }}
    }

}
