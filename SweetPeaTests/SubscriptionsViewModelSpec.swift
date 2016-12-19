//
//  SubscriptionsViewModelSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/15/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble

@testable import SweetPea



class SubscriptionsViewModelSpec: QuickSpec {

    class StubSubscriptionViewModel: SubscriptionsViewModel {
        let testBundle = Bundle(for: type(of: self) as! AnyClass)

        override init?(with url: OPMLUrl) {
            super.init(with: url)
        }
    }


    override func spec() {

//        it("init a SVM from an OPML file url") {
//            let svm = SubscriptionsViewModel(with: url!)
//            expect(svm?.feeds.value.count).toEventually(beGreaterThanOrEqualTo(1), timeout: 2.0, pollInterval: 0.2, description: "No feeds fetched")
//            expect(svm?.feeds.value.count).toEventually(beGreaterThanOrEqualTo(500), timeout: 0.5, pollInterval: 0.2, description: "Doesnt have 500 feeds")
//        }

    }
}
