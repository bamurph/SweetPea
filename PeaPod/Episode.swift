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
    dynamic var title: String = ""
    dynamic var guid: String?
    dynamic var link: String = ""
    dynamic var episodeDescription: String?
    dynamic var pubDate: Date?
    dynamic var enclosure: Enclosure? = Enclosure()
    let feed = LinkingObjects(fromType: Feed.self, property: "items")

    convenience init?(from item: RSSFeedItem) {

        guard
            let title = item.title,
            let link = item.link,
            let enclosure = Enclosure(from: item.enclosure)
            else { return nil }

        self.init()
        self.title = title
        self.guid = item.guid?.value
        self.link = link
        self.episodeDescription = item.description
        self.pubDate = item.pubDate
        self.enclosure = enclosure
    }
}

