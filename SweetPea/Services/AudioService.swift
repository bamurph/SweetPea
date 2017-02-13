//
//  AudioService.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/2/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift

enum FeedAudioError: Error {
    case noEnclosure
    case noMimeType
    case invalidMimeType(String)
    case noURL
}

enum MimeType: String {
    case mp3 = "audio/mpeg"
    case aac = "audio/aac"
}

protocol AudioPlaying {
    func audioPlayer(url: URL) -> Observable<AVPlayer>
}

extension AudioPlaying {
    func audioPlayer(url: URL) -> Observable<AVPlayer> {
        return AudioService().audioPlayer(url: url).shareReplay(1)
    }

}


struct AudioService: AudioPlaying {
    func audioPlayer(url: URL) -> Observable<AVPlayer> {
        return Observable.create { observer in
            let player = AVPlayer(url: url)
                DispatchQueue.global(qos: .background).async {
                    observer.onNext(player)
                    observer.onCompleted()
                }
            return Disposables.create()
        }
    }
}
