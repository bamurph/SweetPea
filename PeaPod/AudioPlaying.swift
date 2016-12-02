//
//  AudioPlaying.swift
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
    func audioPlayer(url: URL) -> Observable<AVAudioPlayer>
}
