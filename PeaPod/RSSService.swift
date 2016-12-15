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

enum RSSServiceErrors: Error {
    case atomSyntax
    case nilURL
}

/// Bare-Bones RSS Service
struct RSSService: RSSProtocol {

    func fetch(url: RSSUrl) -> Observable<RSSFeed> {
        return Observable.create { observer in
            print("subscribed")
            FeedParser.init(URL: url)?.parse { result in
                switch result {
                case .rss(let rssFeed):
                    observer.onNext(rssFeed)
                    observer.onCompleted()
                case .atom:
                    observer.onError(RSSServiceErrors.atomSyntax)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    func rssFeeds(for urls: [URL]) -> Observable<RSSFeed> {
        return Observable.from(urls)
            .map { RSSService().fetch(url: $0) }
            .merge()
    }`
}




