//
//  SubscriptionsViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import FeedKit
import Lepton

/// A collection of all feeds in an OPML file
class SubscriptionsViewModel {
    let disposeBag = DisposeBag()
    //let opmlService = OPMLService()
    let feeds: Variable<[RSSFeed]> = Variable([])

    // Empty Init (used for stub in testing)
    init() {

    }

    // Init with a OPML File
    init?(with url: OPMLUrl) {
        _ = OPMLService().rssUrls(url: url)
            .map { RSSService().rssFeeds(for: $0) }
            .merge()
            .subscribe(onNext: { n in
                self.feeds.value.append(n)

            })
    }

    func allFeeds() -> [RSSFeed] {
        return feeds.value.flatMap { $0 }
    }

    func titles(in feeds: [RSSFeed]) -> [String] {
        return allFeeds().map { $0.title ?? "no title"}
    }


}


