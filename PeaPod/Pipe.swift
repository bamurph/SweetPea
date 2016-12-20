//
//  Pipe.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/14/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

precedencegroup PipePrecedence {
    associativity: left
    higherThan: FunctionArrowPrecedence
}

infix operator |> : PipePrecedence

/// Pipe Forward Operator
///
/// - Parameters:
///   - x: input parameter
///   - f: function input parameter is applied to
/// - Returns: output of f(x)

public func |> <T, U>(x: T, f: (T) -> U) -> U {
    return f(x)
}
