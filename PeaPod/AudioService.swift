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
