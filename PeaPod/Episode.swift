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



class Episode: Object {
    dynamic var title: String?
    dynamic var guid: String?
    dynamic var link: String?
    dynamic var episodeDescription: String?
    dynamic var pubDate: Date?
    dynamic var enclosure: Enclosure?

//    convenience init(with item: RSSFeedItem) {
//        self.init()
//        self.title = item.title
//        self.link = item.link
//        self.episodeDescription = item.description
//        self.enclosure = item.enc
//
//    }
}

