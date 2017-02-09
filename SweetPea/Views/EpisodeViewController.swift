//
//  EpisodeViewController.swift
//  SweetPea
//
//  Created by Ben Murphy on 2/7/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import FeedKit

class EpisodeViewController: UIViewController {

    // MARK: - Dependencies
    let disposeBag = DisposeBag()
    var coordinatorDelegate: EpisodeCoordinator!
    var viewModel: EpisodeViewModel

    @IBOutlet weak var feedTitle: UINavigationItem!
    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var episodeDescription: UITextView!
    @IBOutlet weak var episodeTitle: UILabel!

    // MARK: - Initialization
    init(episode: Episode, feed: Feed, art: UIImage) {
        self.viewModel = EpisodeViewModel(episode: episode, feed: feed, art: art)
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = EpisodeViewModel(episode: aDecoder.value(forKey: "episode") as! Episode, feed: aDecoder.value(forKey:"feed") as! Feed, art: aDecoder.value(forKey: "art") as! UIImage)
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinatorDelegate.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false


        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
        _ = viewModel.art.subscribe(onNext: {n in
            self.art.image = n
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
