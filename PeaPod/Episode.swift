//
//  Episode.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import FeedKit

class Enclosure: Object {
    dynamic var url: String?
    // RealmOptional properties should always be declared with `let`,
    // as assigning to them directly will not work as desired
    let length = RealmOptional<Int64>()
    dynamic var type: String?
}

class Episode: Object {
    dynamic var title: String?
    dynamic var guid: String?
    dynamic var link: String?
    dynamic var episodeDescription: String?
    dynamic var pubDate: Date?
    dynamic var enclosure: Enclosure?
}
