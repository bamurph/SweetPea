//
//  FeedSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/4/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Quick
import Nimble
import Foundation

@testable import SweetPea

class FeedSpec: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "utr", withExtension: "rss")

        describe("it generates a feed from a rss file") {
            let feed = try! RSSService().fetch(url: url!).toBlocking().first()
            it("returns a valid feed:") {
                expect(feed).toNot(beNil())
            }

            it("returns valid feed elements") {
                expect(feed?.iTunes?.iTunesCategories?.first?.category).to(match("Technology"))
                expect(feed?.iTunes?.iTunesCategories?[1].subcategory).to(match("Software How-To"))
                expect(feed?.iTunes?.iTunesOwner?.email).to(match("hello@relay.fm"))
                expect(feed?.iTunes?.iTunesImage).to(match("http://relayfm.s3.amazonaws.com/uploads/broadcast/image/23/radar_artwork.png"))
            }
            
            
            
        }
    }
}
