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
    let service = OPMLService()
    let feeds: Variable<[RSSFeed]> = Variable([])

    init?(with url: URL) {
        service.items(from: url)
            .map { $0 |> withFeedURLs |> rssURLs |> rssFeeds }
            .merge()
            .subscribe(onNext: { n in
                 self.feeds.value.append(n)
            })
            .addDisposableTo(disposeBag)
    }
}


