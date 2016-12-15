//
//  Pipe.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/14/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

precedencegroup PipePrecedence {
    associativity: left
    higherThan: DefaultPrecedence
}

infix operator |> : PipePrecedence

public func |> <T, U>(x: T, f: (T) -> U) -> U {
    return f(x)
}
