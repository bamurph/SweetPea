//
//  StoreSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import RxSwift
import RxRealm


class StoreSpec: QuickSpec {

    override func spec() {
        beforeSuite {
            let subs = store.objects(Subscription.self)
            let feeds = store.objects(Subscription.self)

            try! store.write {
                store.delete(subs)
                store.delete(feeds)
            }
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
                store.deleteSubscription(subscription: sub!)
                expect(store.subscriptions.contains(where: { (sub) -> Bool in
                    sub.title == "A simple podcast."
                })).to(beFalse())
            }
        }
        
        
    }
    
}

