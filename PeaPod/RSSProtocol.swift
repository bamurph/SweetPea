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

protocol RSSProtocol {
    func fetch(url: URL) -> Observable<RSSFeed>
}
 
