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
        
        dump(demoURL)
        let r = try! OPMLService.init(url: OPMLService.demoURL!).parse()
            .toBlocking()
            .single()
        dump(r)

        XCTAssertNotNil(r)

    }
    
}
