//
//  SubscribeCoordinator.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

protocol SubscribeCoordinatorDelegate: class {
    func subscribeCoordinatorDidFinish(subscribeCoordinator: SubscribeCoordinator)
}

class SubscribeCoordinator: Coordinator {
    let window: UIWindow
    weak var delegate: SubscribeCoordinatorDelegate?
    var subscribeViewController = SubscribeViewController(nibName: nil, bundle: nil)

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        subscribeViewController.viewModel.coordinatorDelegate = self
        window.rootViewController = subscribeViewController
    }
}

extension SubscribeCoordinator: SubscribeViewModelDelegate {
    func didAddSubscription(viewModel: SubscribeViewModel) {
        print("Added subscription")
        self.delegate?.subscribeCoordinatorDidFinish(subscribeCoordinator: self)
    }
}

