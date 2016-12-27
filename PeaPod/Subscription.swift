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

enum SubscriptionError: Error {
    case inputMissing
}


/// A subscription object will save / link to additional settings for that sub. 
class Subscription: Object {
    dynamic var title: String = ""
    dynamic var summary: String?
    dynamic var xmlUrl: String = ""
    dynamic var htmlUrl: String?
    dynamic var feed: Feed

    convenience init(with item: OPMLItem) throws {
        self.init()

        guard item.title != nil && item.xmlURL != nil else {
            throw SubscriptionError.inputMissing
        }

        self.title = item.title!
        self.summary = item.summary
        self.xmlUrl = item.xmlURL!
        self.htmlUrl = item.htmlURL!


    }

}
