//
//  EpisodeSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/27/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import Quick
import Nimble
import FeedKit
@testable import SweetPea

class EpisodeSpec: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "utr", withExtension: "rss")
        var feedItems: [RSSFeedItemEnclosure]?
        _ = RSSService().fetch(url: url!).asObservable()
            .map { $0.items.flatMap { $0.flatMap { $0.enclosure }}}
            .toArray()
            .subscribe(onNext: {n in
                feedItems = n.flatMap { $0 }.flatMap { $0 }
            })


        describe("creating an episode from an rss episode item") {
            it("returns a valid episode") {
                let enc = Enclosure(from: feedItems?.first)
                expect(enc).toNot(beNil())

            }
        }
    }

}
