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

@testable import SweetPea

class SweetPeaTests: XCTestCase {

    
    func testOPMLParse() {

        let testBundle = Bundle(for: type(of: self))

        let demoURL = testBundle.url(forResource: "overcast", withExtension: "opml")

        XCTAssert(((try? demoURL?.checkResourceIsReachable()) != nil))

        let service = try? OPMLService(with: demoURL!)

        let items = try! service!.items
            .toBlocking().last()
        dump(items)


    }
    
}
