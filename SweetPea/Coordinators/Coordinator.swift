//
//  Coordinator.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
}

protocol NavigationCoordinator: Coordinator {
    weak var navigationController: UINavigationController? { get set }
    var childCoordinators: NSMutableArray { get }
}
