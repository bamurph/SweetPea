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
    let service: OPMLService
    let feeds: Variable<[RSSFeed]> = Variable([])

    init?(with url: URL) {
        do {
            service = try OPMLService(with: url)
        } catch let error {
            print(error)
            return nil
        }

        // Put on a background queue to avoid blocking during load
        DispatchQueue.global(qos: .background).async {
            self.service.items.value
                .forEach {
                    let svc = RSSService(item: $0)
                    svc.feed.asObservable()
                        .subscribeOn(ConcurrentMainScheduler.instance)
                        .subscribe(onNext: { n in
                            guard n != nil else { return }
                            self.feeds.value.append(n!)
//                            dump(n)
                        }).addDisposableTo(self.disposeBag)
                    svc.update()
            }
        }

        

    }
    
}
