//
//  RSSSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/1/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

@testable import SweetPea
import Quick
import Nimble
import RxSwift
import FeedKit

/// Stub RSS Service

class RSSSpec: QuickSpec {
    override func spec() {
        
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "utr", withExtension: "rss")

        it("fetch rss with a stub provider") {
            let service = RSSService()
            let _ = service.fetch(url: url!)
                .subscribe(onNext: { feed in
                    expect(feed.title).to(match("Under the Radar"))
                    expect(feed.items?.count).to(equal(56))
                })
        }
        
    }
}
