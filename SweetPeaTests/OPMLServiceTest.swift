//
//  OPMLServiceTest.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/6/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble
@testable import SweetPea 
class OPMLServiceTest: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "overcast", withExtension: "opml")

        it("fetches OPML stub ") {
            let service = OPMLService()
            let feeds = service.items(from: url!)

        }
    }
}
