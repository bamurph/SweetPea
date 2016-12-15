//
//  RSSProtocol.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/2/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import FeedKit
import RxSwift

typealias RSSUrl = URL
protocol RSSProtocol {
    func fetch(url: RSSUrl) -> Observable<RSSFeed>
    
}
 
