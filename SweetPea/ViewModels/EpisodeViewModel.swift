//
//  EpisodeViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/24/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class EpisodeViewModel{

    // MARK: - Dependencies
    private let disposeBag = DisposeBag()
    
    // MARK: - Model
    let episode: Observable<Episode>
    let feed: Observable<Feed>
    let art: Observable<UIImage>

    init(episode: Episode, feed: Feed, art: UIImage) {
        self.episode = Observable.from([episode])
        self.feed = Observable.from([feed])
        self.art = Observable.from([art])
    }
}
