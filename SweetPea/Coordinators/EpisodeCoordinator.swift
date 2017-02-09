//
//  EpisodeCoordinator.swift
//  SweetPea
//
//  Created by Ben Murphy on 2/7/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

protocol EpisodeCoordinatorDelegate: class {
    func showEpisodeView(episode: Episode, feed: Feed, art: UIImage)
    func episodeCoordinatorDidFinish(episodeCoordinator: EpisodeCoordinator)
}

class EpisodeCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    let window: UIWindow
    weak var delegate: EpisodeCoordinatorDelegate?
    let episodeViewController: EpisodeViewController

    init(navigationController: UINavigationController?, window: UIWindow, episode: Episode, feed: Feed, art: UIImage) {
        self.window = window
        self.navigationController = navigationController
        self.episodeViewController = EpisodeViewController(episode: episode, feed: feed, art: art)
    }

    func start() {
        navigationController?.pushViewController(self.episodeViewController, animated: true)
    }
}
