//
//  main.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/30/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass? = NSClassFromString("SweetPeaTests.TestingAppDelegate") ?? AppDelegate.self
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass!))
