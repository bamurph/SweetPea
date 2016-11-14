//
//  OPMLService.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/10/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import FeedKit
import RxSwift
import Lepton

struct OPMLService {
    static let demoURL =  Bundle.main.url(forResource: "overcast", withExtension: "opml")

    let url: URL



    func parse() -> Observable<Result> {
        return Observable.create({ (observer) -> Disposable in

            FeedParser.init(URL: self.url)?
                .parse({ (result) in
                    observer.onNext(result)
                    observer.onCompleted()
                })
            return Disposables.create()
        })

    }
}
