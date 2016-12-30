//
//  AudioPlayingSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/2/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//
import UIKit
import Quick
import Nimble
import RxSwift
import FeedKit

@testable import SweetPea

class AudioPlayingSpec: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let urls = testBundle.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []


        it("preps an AVPlayer with an mp3") {
            let service = AudioService()
            let _ = service.audioPlayer(url: urls[0])
                .subscribe(onNext: { n in
                expect(n.rate).to(equal(0.0))
                n.play()
                expect(n.rate).to(equal(1.0))
            })
        }

        it("preps multiple AVPlayers with mp3s") {
            let service = AudioService()
            let _ = Observable
                .from(urls.map { service.audioPlayer(url: $0)})
                .merge()
                .subscribe(onNext: { player in
                    expect(player.rate).to(equal(0.0))
                    player.play()
                    expect(player.rate).to(equal(1.0))
                    player.pause()
                    expect(player.rate).to(equal(0.0))
                })

        }
    }
}
