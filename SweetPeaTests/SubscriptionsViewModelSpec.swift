//
//  SubscriptionsViewModelSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/15/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//
import Foundation
import UIKit
import Quick
import Nimble
import RxSwift
import FeedKit

@testable import SweetPea

class SubscriptionsViewModelSpec: QuickSpec {

    override func spec() {

        describe("loading subscriptions") {
            let testBundle = Bundle(for: type(of: self))
            let testUrl = testBundle.url(forResource: "tests", withExtension: "opml")
            let svm = SubscriptionViewModelStub(with: testUrl!, bundle: testBundle)

            describe("parsing OPML") {
                context("with two feeds") {
                    it("returns two feeds") {
                        expect(svm?.feeds.value.count).toEventually(equal(2))
                    }
                    it("returns many items") {
                        let items = svm?.feeds.value
                            .flatMap { $0.items }
                            .flatMap { $0 }
                        expect(items?.count).to(beGreaterThan(5))
                    }

                    it("returns many titles") {
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
