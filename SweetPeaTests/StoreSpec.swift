//
//  StoreSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RealmSwift
import RxSwift
@testable import SweetPea

class StoreSpec: QuickSpec {

    override func spec() {
        try! store.write {
            store.deleteAll()
        }

        describe("adding a subscription from scratch") {
            it("saves a podcast to the store") {
                store.addSubscription(title: "A simple podcast.", summary: "Not much!", xmlUrl: "http://asimplepodcast.com/rss", htmlUrl: "http://asimplepodcast.com", feed: nil)
                expect(store.subscriptions.contains(where: { (sub) -> Bool in
                    sub.title == "A simple podcast." && sub.summary == "Not much!"
                })).to(beTrue())
            }
        }

        describe("deleting a subscription by title") {
            it("deletes the subscription") {
                let sub = store.objects(Subscription.self).filter("title = 'A simple podcast.'").first
                store.deleteSubscription(sub!)
                expect(store.subscriptions.contains(where: { (sub) -> Bool in
                    sub.title == "A simple podcast."
                })).to(beFalse())
            }
        }


        // TODO: - Complete these tests

        describe("adding a feed from an rss file") {
            it("saves a nonsense feed with no items to the store") {
                store.addFeed(title: "nonsense show", link: "http://nonsenseshow.com/rss", feedDescription: "a really dumb show", language: nil, copyright: nil, managingEditor: nil, webMaster: nil, pubDate: nil, lastBuildDate: Date.init(), imageUrl: nil, categories: nil)
                let feed = store.feeds.first(where: { (feed) -> Bool in
                    feed.title == "nonsense show"
                })
                expect(feed).toNot(beNil())
                expect(feed?.feedDescription).to(equal("a really dumb show"))
            }
        }

        describe("deleting a feed") {
            describe("removing a feed by title") {
                let feed = store.feeds.first(where: { (feed) -> Bool  in
                    feed.title == "nonsense show" })
                context("if the feed exists") {
                    if feed != nil {
                        it("removes the feed") {
                            store.deleteFeed(feed!)
                            expect(feed).to(beNil())
                        }
                    }
                }

            }
        }









        describe("adding an enclosure") {

        }

        describe("adding audio to an enclosure") {

        }
        
        describe("deleting an enclosure") {
            
        }
        
        describe("deleting an audio file") {
            
        }
    }
}
