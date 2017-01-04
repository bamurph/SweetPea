//
//  FeedSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/4/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Quick
import Nimble
import Foundation

@testable import SweetPea

class FeedSpec: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "utr", withExtension: "rss")
    }
}
