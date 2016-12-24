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
    dynamic var enclosure: Enclosure = Enclosure()


    convenience init(with item: RSSFeedItem) throws {
        self.init()

        do {
            self.enclosure = try Enclosure(with: item.enclosure!)
        } catch let error {
            throw error
        }

        guard
            let title = item.title, let link = item.link
            else {
                throw EpisodeError.inputMissing
        }

        self.title = title
        self.link = link
        self.episodeDescription = description

    }
}

