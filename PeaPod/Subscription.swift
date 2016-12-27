//
//  Subscription.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import Lepton
import RxSwift



/// A subscription object will save / link to additional settings for that sub. 
class Subscription: Object {
    dynamic var title: String = ""
    dynamic var summary: String?
    dynamic var xmlUrl: String = ""
    dynamic var htmlUrl: String?
    dynamic var feed: Feed? = nil



}
