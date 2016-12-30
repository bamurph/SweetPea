//
//  DownloadServiceSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/28/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SweetPea

class DownloadServiceSpec: QuickSpec {
    override func spec() {

        let testBundle = Bundle(for: type(of: self))
        let goodUrl = testBundle.url(forResource: nil, withExtension: "mp3")
        let badUrl = testBundle
            .url(forResource: nil, withExtension: "mp3")?
            .appendingPathComponent("bad")


        describe("a download service") {
            let svc = DownloadService()

            describe("downloading from a valid url") {
                it("returns valid data") {
                    let data = try? svc.data(from: goodUrl!).toBlocking().first()
                    expect(data).toNot(beNil())
                    expect(data??.count).to(beGreaterThan(100))
                    expect(data??.count).to(beLessThan(1000000000))
                }
            }

            describe("downloading from an invalid url") {
                it("returns an error") {
                    var error: Error? = nil
                    defer { expect(error).toNot(beNil()) }
                    do {
                       let _ = try svc.data(from: badUrl!).toBlocking().first()
                    } catch (let err) {
                        error = err
                    }
                }
            }

            describe("downloading audio for an enclosure") {

                it("returns valid data") {
                    expect(goodUrl).toNot(beNil())
                    if goodUrl != nil {
                        let enc = Enclosure(url: goodUrl!)
                        let data = try? svc.data(from: enc).toBlocking().first()
                        expect(data).toNot(beNil())
                        expect(data??.count).to(beGreaterThan(100))
                        expect(data??.count).to(beLessThan(1000000000))
                    }
                }

            }

            describe("downloading from an enclosure with invalid url") {
                let enc = Enclosure()
                it("returns an error") {
                    var error: Error? = nil
                    defer { expect(error).toNot(beNil()) }
                    do {
                        let _ = try svc.data(from: enc).toBlocking().first()
                    } catch (let err) {
                        error = err
                    }
                }

            }

        }
    }
}
