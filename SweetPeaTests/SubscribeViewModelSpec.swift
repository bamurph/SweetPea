//
//  SubscribeViewModelSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/9/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import FeedKit
import RxBlocking
@testable import SweetPea

class SubscribeViewModelSpec: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "utr", withExtension: "rss")

        let viewModel = SubscribeViewModel()
        describe("Fetching an RSS Feed") {
            it("can fetch a valid rss feed from a url") {
                _ = viewModel.podcastTitle
                    .subscribe(onNext: { n in
                        expect(n).to(match("Under the Radar"))
                    })
                _ = viewModel.podcastDescription
                    .subscribe(onNext: { n in
                        expect(n.characters.count).to(beGreaterThan(10))
                    })

                viewModel.urlText.value = (url?.absoluteString)!
            }
        }
    }
}
