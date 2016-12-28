//
//  DownloadServiceSpec.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/28/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Quick
import Nimble

class DownloadServiceSpec: QuickSpec {
    override func spec() {

        let testBundle = Bundle(for: type(of: self))

        describe("a download service") {
            let svc = DownloadService()
            describe("downloading from a valid url") {
                let goodUrl = testBundle.url(forResource: nil, withExtension: "mp3")
                expect(goodUrl).toNot(beNil())
                it("returns valid data") {
                    let data = try? svc.dataFromURL(goodUrl!).toBlocking().first()
                    expect(data).toNot(beNil())
                    expect(data??.count).to(beGreaterThan(100))
                    expect(data??.count).to(beLessThan(100000000000))
                }
            }
            describe("downloading from an invalid url") {
                let badUrl = testBundle
                    .url(forResource: nil, withExtension: "mp3")?
                    .appendingPathComponent("bad")
                expect(badUrl).toNot(beNil())
                it("returns an error") {
                    var error: Error? = nil
                    defer { expect(error).toNot(beNil()) }
                    do {
                        try svc.dataFromURL(badUrl!).toBlocking().first()
                    } catch (let err) {
                        error = err
                    }



                }
            }
        }
    }
}
