//
//  Observable+Extensions.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/4/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift

extension Observable where Element : Optional<Any> {
    func unwrap() -> Observable<Any> {
        self.flatMap { $0 == nil ? Observable.empty() : Observable.just($0) }
    }
}
