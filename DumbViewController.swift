//
//  DumbViewController.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol DumbViewCoordinatorDelegate: class {
    func dumbViewDidComplete(dumbViewCoordinator: DumbViewCoordinator)
}

class DumbViewCoordinator: Coordinator {
    let window: UIWindow
    weak var delegate: DumbViewCoordinatorDelegate?
    var dumbViewController = DumbViewController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        dumbViewController.coordinatorDelegate = self
        window.rootViewController = dumbViewController
    }
}

extension DumbViewCoordinator: DumbViewCoordinatorDelegate {
    func dumbViewDidComplete(dumbViewCoordinator: DumbViewCoordinator) {
        self.delegate?.dumbViewDidComplete(dumbViewCoordinator: dumbViewCoordinator)
    }
}

class DumbViewController: UIViewController {
    var coordinatorDelegate: DumbViewCoordinatorDelegate?


    @IBOutlet weak var goBack: UIButton!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Dumb view loaded")

        goBack.rx.tap.asObservable()
            .bindNext {
                self.coordinatorDelegate?.dumbViewDidComplete(dumbViewCoordinator: self.coordinatorDelegate as! DumbViewCoordinator)
        }
    }

}
