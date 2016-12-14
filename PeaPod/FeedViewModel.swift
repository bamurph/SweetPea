//
//  FeedViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/22/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift
import FeedKit
import Lepton



class FeedViewModel {
    let disposeBag = DisposeBag()
    let feed: RSSFeed
    let svc: RSSService

    init(with feed: RSSFeed) {
        self.feed = feed
        svc = RSSService()

    }

}
