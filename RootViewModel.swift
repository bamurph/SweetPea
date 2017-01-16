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
    let episodes: Observable<[Episode]>

    let feeds: Observable<[Feed]>


    init() {
        feeds = Observable.from(store.feeds).map { Array($0) }
        episodes = Observable.from(store.episodes).map { Array($0) }


    }

    // MARK: -

}
