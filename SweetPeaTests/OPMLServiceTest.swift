//
//  OPMLServiceTest.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/6/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import RxSwift
import Quick
import Nimble
import Lepton

@testable import SweetPea

class OPMLServiceTest: QuickSpec {
    override func spec() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "overcast", withExtension: "opml")

        it("fetches OPML stub ") {
            let service = OPMLService()
            let feeds = service.items(from: url!)

            feeds.subscribe(onNext: { feeds in
                feeds.forEach {
                    expect($0.xmlURL).toNot(beNil())
                    expect($0.title).toNot(beNil())
                }



            })
            

        }
    }
}
