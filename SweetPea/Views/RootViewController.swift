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
        let cellID = "Cell"
        let nib = UINib(nibName: "RootTableViewCell", bundle: nil)
        episodeList.register(nib, forCellReuseIdentifier: cellID)
       
        _ = self.viewModel.refresh(oldFeeds: self.viewModel.feeds)


        _ = subscribeButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.coordinatorDelegate.showSubscribe()
            })

        let sortedEpisodes = viewModel.sortedWithImages()

        _ = sortedEpisodes.subscribe(onNext: {n in
            n.forEach { print($0.0.title) }
        })



        _ = sortedEpisodes
            .bindTo(episodeList.rx.items(cellIdentifier: cellID,
                cellType: RootTableViewCell.self)) { (row, element, cell) in
                cell.episodeImage.image = element.1
                cell.episodeTitle.text = element.0.title
                cell.episodeDate.text = element.0.pubDate?.short() ?? "--"
        }

        _ = episodeList.rx.itemSelected
            .subscribe(onNext: {n in
                print("Item #\(n.item) selected")
            })


        



    }
    
    
    
    
}
