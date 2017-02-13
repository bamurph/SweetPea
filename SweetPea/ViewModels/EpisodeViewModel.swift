//
//  EpisodeViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/24/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//
import Foundation
import AVFoundation
import RealmSwift
import RxSwift

class EpisodeViewModel: AudioPlaying {

    // MARK: - Dependencies
    private let disposeBag = DisposeBag()

    // MARK: - Model
    let episode: Observable<Episode>
    let feed: Observable<Feed>
    let art: Observable<UIImage>

    // MARK: - Inputs
    public let playing = Variable<Bool>(false)

    init(episode: Episode, feed: Feed, art: UIImage) {
        self.episode = Observable.from([episode])
        self.feed = Observable.from([feed])
        self.art = Observable.from([art])

        let player$ = self.episode
            .map { $0.enclosure?.url }.filter { $0 != nil }
            .map { URL(string: $0!) }.filter { $0 != nil }
            .flatMap { self.audioPlayer(url: $0!) }

        let playPause$ = Observable.combineLatest(player$, playing.asObservable()) { return ($0, $1) }
            .subscribe(onNext: { n in
                let (avp, play) = n
                switch play {
                case true: avp.play()
                case false: avp.pause()
                }
            })
    }
    
    
}


