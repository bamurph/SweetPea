//
//  Audio.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/28/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift

class Audio: Object {
    dynamic var enclosure: Enclosure? = nil
    dynamic var file: Data? = nil

    // TODO: - properties for playback position & other settings
}
