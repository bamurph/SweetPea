//
//  ComposeSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/14/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble

class ComposeSpec: QuickSpec {
    override func spec() {

        func addTwo(_ x: Int) -> Int {
            return x + 2
        }

        func multiplyThree(_ x: Int) -> Int {
            return x * 3
        }

        let addThenMultiply = multiplyThree • addTwo

        let addTwoThreeTimes = addTwo • addTwo • addTwo

        let multiplyTwice = multiplyThree • multiplyThree

        let threeToTheFourth =  multiplyTwice • multiplyTwice

        it("test some math composition") {
            expect(addThenMultiply(2)).to(equal(12))
            expect(addTwoThreeTimes(2)).to(equal(8))
            expect(2 |> multiplyTwice).to(equal(18))
            expect(2 |> threeToTheFourth).to(equal(162))
        }



    }
}
