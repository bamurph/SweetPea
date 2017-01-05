//
//  Helpers.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/14/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift

struct Resources {
    static let demoURL = Bundle.main.url(forResource: "overcast", withExtension: "opml")
}


/// Ignore all nil values in an observable of optional type
///
/// - Parameter x: an optional value
/// - Returns: an observable sequence of just the single optional value
func ignoreNil<T>(x: T?) -> Observable<T> {
    return x.map { Observable.just($0) } ?? Observable.empty()
}


