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

enum Jump {
    case forward
    case backward
}

class EpisodeViewModel: AudioPlaying {

    // MARK: - Dependencies
    private let disposeBag = DisposeBag()

    // MARK: - Model
    let episode: Observable<Episode>
    let feed: Observable<Feed>
    let art: Observable<UIImage>
    let player = Variable<AVPlayer?>(nil)
    let jumpTime = CMTime(seconds: 15.00, preferredTimescale: 1)

    // MARK: - Inputs
    public let playing = Variable<Bool>(false)
    public let jump = Variable<Jump?>(nil)

    init(episode: Episode, feed: Feed, art: UIImage) {
        self.episode = Observable.from([episode])
        self.feed = Observable.from([feed])
        self.art = Observable.from([art])

        _ = self.episode
            .map { $0.enclosure?.url }.filter { $0 != nil }
            .map { URL(string: $0!) }.filter { $0 != nil }
            .flatMap { self.audioPlayer(url: $0!) }
            .bindTo(player)

        _ = playing.asObservable()
            .subscribe(onNext: { n in
                switch n {
                case true: self.player.value?.play()
                case false: self.player.value?.pause()
                }
            })

        _ = jump.asObservable()
            .subscribe(onNext: { n in
                guard let item = self.player.value?.currentItem else { return }
                let targetTime: CMTime
                switch n {
                case .some(.forward):
                    targetTime = item.currentTime() + self.jumpTime
                case .some(.backward):
                    targetTime = item.currentTime() - self.jumpTime
                case .none: return
                }
                item.seek(to: targetTime)
            })
    }
}






