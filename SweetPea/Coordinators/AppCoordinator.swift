//
//  AppCoordinator.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

class AppCoordinator: NavigationCoordinator {
    let window: UIWindow
    weak var navigationController: UINavigationController?
    let rootViewController = RootViewController()
    let childCoordinators = NSMutableArray()

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController(rootViewController: rootViewController)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
        self.rootViewController.coordinatorDelegate = self
    }

    func start() {

    }
}

extension AppCoordinator: EpisodeCoordinatorDelegate {

    func showEpisodeView(episode: Episode, feed: Feed, art: UIImage) {
        let episodeCoordinator = EpisodeCoordinator(navigationController: self.navigationController, window: window, episode: episode, feed: feed, art: art, delegate: self)
        childCoordinators.add(episodeCoordinator)
        episodeCoordinator.start()
    }

    func episodeCoordinatorDidFinish(episodeCoordinator: EpisodeCoordinator) {
        _ = navigationController?.popViewController(animated: true)
        childCoordinators.removeObject(identicalTo: episodeCoordinator)
        window.rootViewController = rootViewController
    }

}

extension AppCoordinator: SubscribeCoordinatorDelegate {
    func showSubscribe() {
        let subscribeCoordinator = SubscribeCoordinator(navigationController: self.navigationController, window: window)
        subscribeCoordinator.delegate = self
        childCoordinators.add(subscribeCoordinator)
        subscribeCoordinator.start()
    }

    func subscribeCoordinatorDidFinish(subscribeCoordinator: SubscribeCoordinator) {
        _ = navigationController?.popViewController(animated: true)
        childCoordinators.removeObject(identicalTo: subscribeCoordinator)
        //window.rootViewController = rootViewController
        rootViewController.episodeList.reloadData()

    }
}

