//
//  RSSService.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/14/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import FeedKit
import RxSwift
import Lepton




/// Bare-Bones RSS Service to fetch items from a single RSS feed
/// Item type is Lepton OPML instance
struct RSSService {
    let item: Item
    let feed: Variable<RSSFeed?> = Variable(nil)

    func update() {
        FeedParser.init(URL: URL(string: item.xmlURL!)!)?.parse { result in
            switch result {
            case .rss(let rssFeed):
                self.feed.value = rssFeed
            //observer.onCompleted()
            case .atom: break
            case .failure(let error):
                print(error)
            }
        }
    }
}
