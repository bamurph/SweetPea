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
}

/// Bare-Bones RSS Service
struct RSSService: RSSProtocol {

    func fetch(url: URL) -> Observable<RSSFeed> {
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
}

/// Stub RSS Service

struct StubRSSService: RSSProtocol {


    func fetch(url: URL) -> Observable<RSSFeed> {
        let testBundle = Bundle(for: type(of: AppDelegate.self) as! AnyClass)
        let url = testBundle.url(forResource: "mtjc", withExtension: "rss")

        return Observable.create { observer in
            FeedParser.init(URL: url!)!.parse { result in
                observer.onNext(result.rssFeed!)
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
        
    }
}
