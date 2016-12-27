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

        // TODO: - rewrite this so we can test before/after teardown

        describe("returns collections of stored objects") {

            describe("returns all stored subscriptions") {
                context("when there are no stored feeds") {
                    it("returns no feeds") {
                        expect(store.subscriptions.count).to(equal(0))
                    }
                }

            }
        }

        describe("creates episode objects from rss file") {

        }


    }

}

