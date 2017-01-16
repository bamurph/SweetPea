//
//  RootViewController.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class RootViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var episodeList: UITableView!

    var coordinatorDelegate: AppCoordinator!
    let viewModel = RootViewModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RootTableViewCell", bundle: nil)
        episodeList.register(nib, forCellReuseIdentifier: "RootTableViewCell")

        _ = subscribeButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.coordinatorDelegate.showSubscribe()
            })


    }




}