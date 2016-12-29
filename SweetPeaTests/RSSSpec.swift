//
//  RSSSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/1/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import FeedKit
import RxBlocking

/// Stub RSS Service

class RSSSpec: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "utr", withExtension: "rss")

        describe("Fetching an RSS Feed") {
            it("can fetch valid rss feed from a url") {
                let service = RSSService()
                let _ = service.fetch(url: url!)
                    .subscribe(onNext: { feed in
                        expect(feed.title).to(match("Under the Radar"))
                        expect(feed.items?.count).to(equal(56))
                        expect(feed.title).toNot(match("Back to Work"))
                    })
            }

            it("returns an error for an invalid url") {
                let badUrl = URL(string: "http://badpodcasturl.com/badfeed.rss")
                let service = RSSService()
                do {
                    _ = try service.fetch(url: badUrl!)
                        .toBlocking().toArray()
                } catch let error {
                    expect(error.localizedDescription).to(equal(RSSServiceError.badUrl.localizedDescription))
                }
            }

            it("returns a collection of RSS feeds") {
                let urls = testBundle.urls(forResourcesWithExtension: "rss", subdirectory: nil)
                let service = RSSService()
                let _ = service.rssFeeds(for: urls!)
                    .subscribe(onNext: { feed in
                        if feed.title == "Dan Carlin's Hardcore History" {
                            expect(feed.items?.count).to(equal(11))
                        }

                        if feed.title == "Under the Radar" {
                            expect(feed.items?.count).to(equal(56))
                        }
                    })
            }
        }
    }
}

