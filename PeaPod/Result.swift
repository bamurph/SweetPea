//
//  Result.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/27/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//
import Foundation

enum Result<Value> {
    case Success(Value)
    case Failure(Error)
}
