//
//  EpisodeCoordinator.swift
//  SweetPea
//
//  Created by Ben Murphy on 2/7/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

protocol EpisodeCoordinatorDelegate: class   {
    func showEpisodeView(episode: Episode, feed: Feed, art: UIImage)
    func episodeCoordinatorDidFinish(episodeCoordinator: EpisodeCoordinator)
}

protocol EpisodeViewCoordinatorDelegate: class, Coordinator {
    weak var navigationController: UINavigationController? { get set }
}

class EpisodeCoordinator: EpisodeViewCoordinatorDelegate {
    weak var navigationController: UINavigationController?
    let window: UIWindow
    weak var delegate: EpisodeCoordinatorDelegate?

    var episodeViewController: EpisodeViewController

    init(navigationController: UINavigationController?, window: UIWindow, episode: Episode, feed: Feed, art: UIImage, delegate: EpisodeCoordinatorDelegate) {
        self.delegate = delegate
        self.window = window
        self.navigationController = navigationController
        self.episodeViewController = EpisodeViewController(episode: episode, feed: feed, art: art, delegate: nil)
    }

    func start() {
        self.episodeViewController.viewCoordinatorDelegate = self
        navigationController?.pushViewController(self.episodeViewController, animated: true)
    }
}
