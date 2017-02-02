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
    fileprivate let separator = "\u{FFFF}"
    
    dynamic var title: String = ""
    dynamic var link: String = ""
    dynamic var feedDescription: String? // property for rss 'description' tag
    dynamic var language: String?
    dynamic var copyright: String?
    dynamic var managingEditor: String?
    dynamic var webMaster: String?
    dynamic var pubDate: Date?
    dynamic var lastBuildDate: Date?
    dynamic var imageUrl: String?
    dynamic var imageLocalUrl: String?

    override static func primaryKey() -> String {
        return "link"
    }

    /// Inverse relationship to subscriptions
    let subscription = LinkingObjects(fromType: Subscription.self, property: "feed")
    // List of Items in the Feed

    var items = List<Episode>()

    // Need to bypass Realm's limitations on arrays
    // Serialize array of strings into a single string to store and back again to load
    fileprivate dynamic var _categories: String?
    var categories: [String] {
        get { return _categories?.components(separatedBy: separator) ?? [] }
        set { _categories = newValue.isEmpty ? nil : newValue.joined(separator: separator) }
    }

    override static func ignoredProperties() -> [String] {
        return ["categories"]
    }

    // TODO: - Make sure categories are separated properly when parsed

    func separated(_ categories: String?) -> [String] {
        return categories?.components(separatedBy: separator) ?? []
    }

    func joinedCategories() -> String {
        return categories.joined(separator: separator)
    }

    // TODO: - Input categories properly

    func stringsFrom(categories: [RSSFeedCategory]?) -> [String]? {
        return categories.flatMap { $0.flatMap { $0.value }
        }
    }

    convenience init(from rss: RSSFeed) {
        self.init()
        self.title = rss.title!
        self.link = rss.link!
        self.feedDescription = rss.description
        self.language = rss.language
        self.copyright = rss.copyright
        self.managingEditor = rss.managingEditor
        self.webMaster = rss.webMaster
        self.pubDate = rss.pubDate
        self.lastBuildDate = rss.lastBuildDate
        self.imageUrl = rss.iTunes?.iTunesImage
        self.categories = self.stringsFrom(categories: rss.categories) ?? [""]
        let episodes = rss.items.map { $0.flatMap { Episode(from: $0) } } ?? []
        self.items.append(objectsIn: episodes)
        self.imageLocalUrl = nil
    }

    
}
