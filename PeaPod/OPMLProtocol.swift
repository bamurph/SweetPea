//
//  OPMLProtocol.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/6/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import FeedKit
import RxSwift
import Lepton

protocol OPMLProtocol {
    typealias OPMLItem = Item
    typealias OPMLUrl = URL
    
    func items(from url: OPMLUrl) -> Observable<[OPMLItem]>
}
