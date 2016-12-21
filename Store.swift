//
//  Store.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

extension Realm {
    var subscriptions: Results<Subscription> {
        return objects(Subscription.self)
    }
}

let store = try! Realm()
