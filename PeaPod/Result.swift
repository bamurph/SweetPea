//
//  Result.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/27/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//
import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

extension Result {
    func flatMap<U>(_ transform: (Value) -> Result<U>) -> Result<U> {
        switch self {
        case .success(let val): return transform(val)
        case .failure(let err): return .failure(err)
        }
    }

    func flatMap<U>(_ transform: (Value) -> Result<U>, onFailure: () -> Void) -> Result<U> {
        switch self {
        case .success(let val): return transform(val)
        case .failure(let err):
            onFailure()
            return .failure(err)
        }
    }


    /// Convert a Result back to standard Swift 'throws' style error handling
    public func unwrap() throws -> Value {
        switch self {
        case .success(let v):
            return v
        case .failure(let e):
            throw e
        }
    }
}
