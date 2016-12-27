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

enum EpisodeError: Error {
    case inputMissing
}

class Episode: Object {
    dynamic var title: String = ""
    dynamic var guid: String?
    dynamic var link: String = ""
    dynamic var episodeDescription: String?
    dynamic var pubDate: Date?
    dynamic var enclosure: Enclosure? = Enclosure()

}

