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


class StoreSpec: QuickSpec {
    override func spec() {
        describe("returns collections of stored objecets") {

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
                let svc = OPMLService()
                it("creates two subs in the store") {
                    svc.items(from: testUrl!)
                        .map { $0.map { Subscription(from: $0) }}
                        .subscribe(onNext: {n in
                            try! store.write {
                                code
                            }
                        })
                }
            }
        }
        
    }
}
