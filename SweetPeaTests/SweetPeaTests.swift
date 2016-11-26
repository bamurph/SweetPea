//
//  SweetPeaTests.swift
//  SweetPeaTests
//
//  Created by Ben Murphy on 11/10/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking
import FeedKit
import Lepton

@testable import SweetPea

class SweetPeaTests: XCTestCase {

    
    func testOPMLParse() {

        let testBundle = Bundle(for: type(of: self))

        let demoURL = testBundle.url(forResource: "overcast", withExtension: "opml")

        XCTAssert(((try? demoURL?.checkResourceIsReachable()) != nil))

        let service = try? OPMLService(with: demoURL!)

        let items: [Item] = service!.items.value
        XCTAssert(items.count == 10)
        dump(items)

    }

    func testSubViewModel() {
        let hasResults = expectation(description: "it has a result")
        let testBundle = Bundle(for: type(of: self))
        let demoURL = testBundle.url(forResource: "overcast", withExtension: "opml")

        let svm = SubscriptionsViewModel(with: demoURL!)


        defer {
            let sub = svm?.feeds.asObservable()
                .subscribe(onNext: { n in
                    dump(n.count)
                    hasResults.fulfill()
                })

            waitForExpectations(timeout: 5) { error in
                sub?.dispose()
            }
        }
    }

    func testFeedViewModel() {
        let demoItem = Item(title: "Dan Carlin\'s Hardcore History", summary: nil, xmlURL: "https://feeds.feedburner.com/dancarlin/history?format=xml", query: nil, tags: [])

        let service = RSSService(item: demoItem)
        service.update()
        let audioIsPlaying = expectation(description: "Audio is Playing")

        let sub = service.feed.asObservable()
            .subscribe(onNext: { n in
                let fvm = FeedViewModel(with: n!)
                XCTAssert((fvm.feed.items?.count)! > 0)

                let f = fvm.feed.items?
                    .filter { $0.enclosure != nil }
                    .first

                guard let i = f else { XCTFail(); return }

                let audio = fvm.audio(for: i)
                    .subscribe(onNext: { n in
                        print(n.url)
                        if n.play() {
                            audioIsPlaying.fulfill()
                        }
                        dump(n)
                    })
            })
        waitForExpectations(timeout: 100) { error in
            
        }
        

    }



    func testRSSServiceInit() {
        let demoItem = Item(title: "Dan Carlin\'s Hardcore History", summary: nil, xmlURL: "https://feeds.feedburner.com/dancarlin/history?format=xml", query: nil, tags: [])

        let hasItems = expectation(description: "has more than 0 items")

        let service = RSSService(item: demoItem)
        service.update()

        let sub = service.feed.asObservable()
            .subscribe(onNext: { n in
                dump(n)
                if (n?.items?.count) != nil {
                    hasItems.fulfill()
                }
                // dump(n)
            })
        waitForExpectations(timeout: 3) { error in
            if let error = error {
                print(error)
            }
            sub.dispose()
        }

    }
    
}
