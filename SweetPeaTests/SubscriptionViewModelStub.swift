//
//  SubscriptionViewModelStub.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/19/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation

@testable import SweetPea
class SubscriptionViewModelStub: SubscriptionsViewModel {
    
    let bundle: Bundle
    
    
    init?(with url: OPMLUrl, bundle: Bundle) {
        self.bundle = bundle
        super.init()
        _ = OPMLServiceStub(with: bundle).rssUrls(url: url)
            .map { RSSService().rssFeeds(for: $0) }
            .merge()
            .subscribe(onNext: { (feed) in
                self.feeds.value.append(feed)
            })
    }
}
