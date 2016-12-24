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
        describe("creates subscription objects from opml file") {
            context("when there are two subs in the opml file") {
                let testBundle = Bundle(for: type(of: self))
                let testUrl = testBundle.url(forResource: "tests", withExtension: "opml")
                let svc = OPMLServiceStub(with: testBundle)
                let subs = store.objects(Subscription.self)
                let items = svc.items(testUrl!)
                it("creates two subs in the store") {
                    
                    svc.withFeedURLs(items)
                        .map { $0.map { Subscription(from: $0)}}
                        .map { Observable.from($0) }
                        .merge()
                        .subscribe(store.rx.add())
                        .dispose()

                    Observable.from(subs)
                        .subscribe(onNext: { n in
                            expect(n.count).to(equal(2))
                            expect(n.count).toNot(equal(55))
                        }).dispose()

                }
            }
        }

        describe("creates epeisode objects from rss file") {

        }


    }

}

