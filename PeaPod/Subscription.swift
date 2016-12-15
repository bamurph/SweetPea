//
//  Subscription.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/15/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation

enum FeedType: String {
    case rss
    case atom
}

class Subscription {
    let type: FeedType
    let title: String
    let htmlUrl: URL
    let xmlUrl: URL

    init(type: FeedType, title: String, htmlUrl: URL, xmlUrl: URL) {
        self.type = type
        self.title = title
        self.htmlUrl = htmlUrl
        self.xmlUrl = xmlUrl
    }
}
