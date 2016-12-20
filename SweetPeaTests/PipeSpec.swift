//
//  PipeSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/20/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble
@testable import SweetPea

class PipeSpec: QuickSpec {
    override func spec() {
        describe("Forward pipe operator takes a value T and applies it to function F") {
            let val = 5
            func addOne(value: Int) -> Int {
                return value + 1
            }


            let a = [1,2,3].reduce(0, +)

            func lengths(of strings: [String]) -> [Int] {
                return  strings
                        .map { Int($0.characters.count)}

            }

            func total(of ints: [Int]) -> Int {
                return ints.reduce(0, +)
            }

            let strings = [
                "Here's to the crazy ones",
                "The misfits, the rebels",
                "The round pegs in square holes"
            ]
            expect(val |> addOne).to(equal(6))

            let los = strings |> lengths |> total
            expect(los).to(beGreaterThan(25))
            

        }
    }
}
