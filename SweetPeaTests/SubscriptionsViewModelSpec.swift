//
//  SubscriptionsViewModelSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/15/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import FeedKit


class SubscriptionsViewModelSpec: QuickSpec {

    override func spec() {

        describe("Prepare a collection of subscriptions for view") {
            let testBundle = Bundle(for: type(of: self))
            let testUrl = testBundle.url(forResource: "tests", withExtension: "opml")
            let svm = SubscriptionViewModelStub(with: testUrl!, bundle: testBundle)

            describe("Parse the OPML file for the feeds") {
                context("when there are two feeds in test.opml") {
                    it("has two feeds") {
                        expect(svm?.feeds.value.count).toEventually(equal(2))
                    }
                    it("has many items in those feeds") {
                        let items = svm?.feeds.value
                            .flatMap { $0.items }
                            .flatMap { $0 }
                        expect(items?.count).to(beGreaterThan(5))
                    }

                    it("has many titles in those feeds") {
                        let fs = svm!.allFeeds()

                        func titles(in feeds: [RSSFeed]) -> [String] {
                            return svm!.titles(in: feeds)
                        }
                        let all = fs |> titles
                        expect(all.count).to(beGreaterThan(1))
                    }


                }
            }

        }


    }
}
