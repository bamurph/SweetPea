//
//  SubscribeCoordinator.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

protocol SubscribeCoordinatorDelegate: class {
    func showSubscribe()
    func subscribeCoordinatorDidFinish(subscribeCoordinator: SubscribeCoordinator)
}

class SubscribeCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    let window: UIWindow
    weak var delegate: SubscribeCoordinatorDelegate?

    var subscribeViewController = SubscribeViewController(nibName: nil, bundle: nil)

    init(navigationController: UINavigationController?, window: UIWindow) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        subscribeViewController.viewModel.coordinatorDelegate = self
        subscribeViewController.viewCoordinatorDelegate = self
        navigationController?.pushViewController(self.subscribeViewController, animated: true)
    }
}

extension SubscribeCoordinator: SubscribeViewModelDelegate {
    func didAddSubscription(viewModel: SubscribeViewModel) {
        self.delegate?.subscribeCoordinatorDidFinish(subscribeCoordinator: self)
    }
}

protocol SubscribeViewCoordinatorDelegate {
    weak var navigationController: UINavigationController? { get set }
}

extension SubscribeCoordinator: SubscribeViewCoordinatorDelegate { }

