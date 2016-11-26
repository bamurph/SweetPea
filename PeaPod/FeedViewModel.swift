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

class FeedViewModel {
    let disposeBag = DisposeBag()
    let feed: RSSFeed


    init(with feed: RSSFeed) {
        self.feed = feed
    }


    func audio(for item: RSSFeedItem) -> Observable<AVAudioPlayer> {
        return Observable.create { observer in
            guard let enclosure = item.enclosure else {
                observer.onError(FeedAudioError.noEnclosure)
                return Disposables.create()
            }
            guard let typeString = enclosure.attributes?.type else {
                observer.onError(FeedAudioError.noMimeType)
                return Disposables.create()
            }
            guard let mimeType = MimeType.init(rawValue: typeString) else {
                observer.onError(FeedAudioError.invalidMimeType(enclosure.attributes?.type ?? "noValue"))
                return Disposables.create()
            }
            guard let fileURL = URL(string: enclosure.attributes?.url ?? "") else {
                observer.onError(FeedAudioError.noURL)
                return Disposables.create()
            }

            do {
                let player = try AVAudioPlayer(contentsOf: fileURL, fileTypeHint: mimeType.rawValue)
                DispatchQueue.global(qos: .background).async {
                    if player.prepareToPlay() {
                        observer.onNext(player)
                        observer.onCompleted()
                    }
                }
            } catch let outError {
                observer.onError(outError)
            }


            return Disposables.create()
        }
    }
    
}
