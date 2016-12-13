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
    func items(from url: URL) -> Observable<[Item]>
}
