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
    var subscribeViewController: SubscribeViewController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        subscribeViewController = storyboard.instantiateViewController(withIdentifier: "Subscribe") as? SubscribeViewController

        guard let subscribeViewController = subscribeViewController else { return }
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

