//
//  Enclosure.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/24/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import FeedKit

enum EnclosureError: Error {
    case inputMissing
}

class Enclosure: Object {
    dynamic var url: String = ""
    dynamic var type: String = ""
    let length: RealmOptional<Int64> = RealmOptional(nil)

    convenience init(with enclosure: RSSFeedItemEnclosure) throws {
        self.init()
        guard
            let url = enclosure.attributes?.url, let type = enclosure.attributes?.type
            else {
                throw EnclosureError.inputMissing
        }
        self.url = url
        self.type = type
        self.length.value = enclosure.attributes?.length
    }
    
}
