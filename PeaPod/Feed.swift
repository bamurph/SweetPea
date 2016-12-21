//
//  Feed.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import FeedKit




class Feed: Object {
    dynamic var title: String?
    dynamic var link: String?
    dynamic var feedDescription: String? // property for rss 'description' tag
    dynamic var language: String?
    dynamic var copyright: String?
    dynamic var webMaster: String?
    dynamic var pubDate: Date?
    dynamic var lastBuildDate: Date?


    fileprivate dynamic var _categories: String?

}
