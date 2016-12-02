//
//  FeedViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/22/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift
import FeedKit
import Lepton



class FeedViewModel {
    let disposeBag = DisposeBag()
    let feed: RSSFeed


    init(with feed: RSSFeed) {
        self.feed = feed
    }

    func audioPlayer(url: URL) -> Observable<AVAudioPlayer> {
        return Observable.create { observer in
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                DispatchQueue.global(qos: .background).async {
                    observer.onNext(player)
                    observer.onCompleted()
                }
            }
            catch let outError {
                observer.onError(outError)
            }
            return Disposables.create()
        }
    }


    
}
