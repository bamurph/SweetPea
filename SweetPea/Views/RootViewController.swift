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

    // MARK: - Dependencies
    let disposeBag = DisposeBag()
    var coordinatorDelegate: AppCoordinator!
    let viewModel = RootViewModel()
    let subscribeButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)

    @IBOutlet weak var episodeList: UITableView!

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
        coordinatorDelegate.navigationController?.navigationBar.topItem?.rightBarButtonItem = subscribeButton
       

        _ = subscribeButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                self.coordinatorDelegate.showSubscribe()
            })

        let sortedEpisodes = viewModel.sortedWithImages().shareReplay(1)
        _ = sortedEpisodes
            .bindTo(episodeList.rx.items(cellIdentifier: cellID,
                cellType: RootTableViewCell.self)) { (row, element, cell) in
                cell.episodeImage.image = element.1
                cell.episodeTitle.text = element.0.title
                cell.episodeDate.text = element.0.pubDate?.short() ?? "--"

        }

        func getItem<T>(in observableArray: Observable<[T]>, atIndex: IndexPath) {
            _ = observableArray.map { $0[atIndex.item] }
                .subscribe(onNext: { n in
                    guard
                        let (episode, art) = n as? (Episode, UIImage?),
                        let feed = episode.feed.first,
                        art != nil
                        else { return }
                    self.coordinatorDelegate.showEpisodeView(episode: episode, feed: feed, art: art!)
                })
        }

         _ = episodeList.rx.itemSelected
            .subscribe(onNext: {n in
                getItem(in: sortedEpisodes, atIndex: n)

            })

    }

    
    
    
    
    
}
