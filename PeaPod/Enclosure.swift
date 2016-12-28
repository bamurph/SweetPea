//
//  Enclosure.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/24/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import FeedKit

class Enclosure: Object {
    dynamic var url: String = ""
    dynamic var type: String = ""
    let length: RealmOptional<Int64> = RealmOptional(nil)
}


