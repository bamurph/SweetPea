//
//  AppDelegate.swift
//  PeaPod
//
//  Created by Ben Murphy on 11/10/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit
import RealmSwift


class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var appCoordinator: AppCoordinator = {
        return AppCoordinator(window: self.window!)
    }()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Migrations.run()

        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator.start()


        return true
    }

}

