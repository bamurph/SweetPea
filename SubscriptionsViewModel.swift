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


        self.service.items.value
            .forEach {
                let svc = RSSService(item: $0)
                svc.feed.asObservable()
                    .subscribeOn(ConcurrentMainScheduler.instance)
                    .subscribe(onNext: { n in
                        guard n != nil else { return }
                        self.feeds.value.append(n!)

                    }).addDisposableTo(disposeBag)
                svc.update()
        }
        
        
    }
    
}
