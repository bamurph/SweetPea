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
        
    }
}
