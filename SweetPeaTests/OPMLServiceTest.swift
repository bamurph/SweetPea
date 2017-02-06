//
//  OPMLServiceTest.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/6/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//
import Foundation
import RxSwift
import Quick
import Nimble
import Lepton
@testable import SweetPea

class OPMLServiceTest: QuickSpec {
    override func spec() {

        describe("an OPML file") {
            let testBundle = Bundle(for: type(of: self))
            let svc = OPMLServiceStub(with: testBundle)
            let url = testBundle.url(forResource: "tests", withExtension: "opml")
            var items = [OPMLItem]()
            _ = svc.items(url!).subscribe(onNext: {n in
                items = n
            })

            var rssUrls = [RSSUrl]()
            _ = svc.rssUrls(url: url!).subscribe(onNext: {n in
                rssUrls = n
            })


            describe("count items") {
                context("when there are two items in the opml file") {
                    it("has two items") {
                        expect(items.count).toEventually(equal(2))
                        expect(items.count).toNotEventually(equal(5))
                    }
                }
            }

            describe("convert strings to URLs") {
                context("when the urls are local") {
                    it("returns valid urls") {
                        let urls = items.map { URL(string: $0.xmlURL!) }
                        expect(urls).toNot(beNil())
                    }
                }

                context("when an rss url is local") {
                    it("returns a complete url") {
                        expect(rssUrls).toNot(beNil())
                    }
                }
            }


//            describe("check xmlURL strings") {
//                context("when a rss feed is local") {
//                    it("is represented as a filename") {
//                        let rssUrls = svc.rssUrls(url: url!)
//
//                    }
//                }
//            }

        }




    }
}
