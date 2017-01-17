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

    /// Inverse relationship to locally saved audio
    let localAudio = LinkingObjects(fromType: Audio.self, property: "enclosure")

    convenience init(url: URL) {
        self.init()
        self.url = url.absoluteString
    }

    convenience init?(from rssEnclosure: RSSFeedItemEnclosure?) {

        guard
            let url = rssEnclosure?.attributes?.url,
            let type = rssEnclosure?.attributes?.type
            else { return nil }

        self.init()
        self.url = url
        self.type = type
    }
}


