//
//  File.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/18/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import FeedKit

struct OPMLServiceStub {
    let testBundle: Bundle
    var fetchedFile = OPMLService().fetchedFile
    var extractedItems = OPMLService().extractedItems
    var items = OPMLService().items
    var withFeedURLs = OPMLService().withFeedURLs


    func rssUrls(items: Observable<[OPMLItem]>) -> Observable<[RSSUrl]> {
        let itemsWithURLs = items |> withFeedURLs
        return itemsWithURLs.map {
            $0.map {
                self.testBundle.url(forResource: $0.xmlURL!, withExtension: nil)!
            }
        }
    }

    func rssUrls(url: OPMLUrl) -> Observable<[RSSUrl]> {
        return url |> items |> rssUrls
    }

    init(with bundle: Bundle) {
        testBundle = bundle
    }
}
