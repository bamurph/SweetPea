//
//  Compose.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/14/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator • : CompositionPrecedence

public func • <T, U, V>(f: @escaping (U) -> V, g: @escaping (T) -> U) -> (T) -> V {
    return compose(f, g)
}

public func compose<T, U, V>(_ f: @escaping (U) -> V, _ g: @escaping (T) -> U) -> (T) -> V {
    return { x in f(g(x)) }
}
