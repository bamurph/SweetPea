//
//  AppCoordinator.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController = RootViewController()
    let childCoordinators = NSMutableArray()

    init(window: UIWindow) {
        self.window = window
        rootViewController.coordinatorDelegate = self
        window.rootViewController = rootViewController
    }

    func start() {

    }
}

extension AppCoordinator: SubscribeCoordinatorDelegate {
    func showSubscribe() {
        let subscribeCoordinator = SubscribeCoordinator(window: window)
        childCoordinators.add(subscribeCoordinator)
        subscribeCoordinator.delegate = self
        subscribeCoordinator.start()
    }

    func subscribeCoordinatorDidFinish(subscribeCoordinator: SubscribeCoordinator) {
        childCoordinators.removeObject(identicalTo: subscribeCoordinator)
    }
}
