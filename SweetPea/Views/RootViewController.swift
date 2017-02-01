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
        _ = viewModel.refresh(oldFeeds: viewModel.feeds)

        _ = subscribeButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.coordinatorDelegate.showSubscribe()
            })

        let sortedEpisodes = viewModel.episodes
            .scan([Episode]()) {eps, e in
                return eps + [e]
            }
            .map {
                $0.sorted {
                    switch ($0.pubDate, $1.pubDate) {
                    case let (.some(val1), .some(val2)): return val1 > val2
                    default: return false
                    }
                }
        }

        _ = sortedEpisodes
            .bindTo(episodeList.rx.items(cellIdentifier: cellID, cellType: RootTableViewCell.self)) { (row, element, cell) in
                cell.feedTitle.text = element.feed.first?.title ?? "--"
                cell.episodeTitle.text = element.title
                cell.episodeDate.text = element.pubDate?.short() ?? "--"

        }

        let itemSelected = episodeList.rx.itemSelected

        _ = Observable
            .combineLatest(sortedEpisodes, itemSelected) { (eps, i) -> Episode in
                return eps[i.item]
            }
            .subscribe(onNext: {n in
                print(n.title)
            })
        



    }
    
    
    
    
}
