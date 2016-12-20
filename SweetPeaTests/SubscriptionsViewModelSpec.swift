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

@testable import SweetPea


class SubscriptionsViewModelSpec: QuickSpec {

    override func spec() {
        describe("Prepare a collection of subscriptions for view") {
            let testBundle = Bundle(for: type(of: self))
            let testUrl = testBundle.url(forResource: "tests", withExtension: "opml")
            _ = SubscriptionViewModelStub(with: testUrl!, bundle: testBundle)

//            describe("Parse the OPML file for the feeds") {
//                context("when there are two feeds in test.opml") {
//                    it("has two feeds") {
//                        expect(svm?.feeds.value.count).toEventually(equal(2))
//                    }
//                    it("has many items in those feeds") {
//                        let items = svm?.feeds.value
//                            .flatMap { $0.items }
//                            .flatMap { $0 }
//                        expect(items?.count).to(beGreaterThan(5))
//                    }
//
//                    it("has many titles in those feeds") {
//                        let fs = svm!.allFeeds()
//                        
//                        func titles(in feeds: [RSSFeed]) -> [String] {
//                            return svm!.titles(in: feeds)
//                        }
//                        let all = titles(in: fs)
//                        let all1 = fs |> titles
//                    }
//
//
//                }
//            }
            
        }

//        it("init a SVM from an OPML file url") {
//            let svm = SubscriptionsViewModel(with: url!)
//            expect(svm?.feeds.value.count).toEventually(beGreaterThanOrEqualTo(1), timeout: 2.0, pollInterval: 0.2, description: "No feeds fetched")
//            expect(svm?.feeds.value.count).toEventually(beGreaterThanOrEqualTo(500), timeout: 0.5, pollInterval: 0.2, description: "Doesnt have 500 feeds")
//        }

    }
}
