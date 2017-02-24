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
    var viewCoordinatorDelegate: EpisodeViewCoordinatorDelegate!
    var viewModel: EpisodeViewModel

    // MARK: - Outlets / Inputs
    @IBOutlet weak var art: UIImageView!
    @IBOutlet weak var episodeDescription: UITextView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var fastForward: UIButton!
    @IBOutlet weak var rewind: UIButton!

    // MARK: - Initialization
    init(episode: Episode, feed: Feed, art: UIImage, delegate: EpisodeViewCoordinatorDelegate?) {
        self.viewModel = EpisodeViewModel(episode: episode, feed: feed, art: art)
        self.viewCoordinatorDelegate = delegate
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = EpisodeViewModel(episode: aDecoder.value(forKey: "episode") as! Episode, feed: aDecoder.value(forKey:"feed") as! Feed, art: aDecoder.value(forKey: "art") as! UIImage)
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCoordinatorDelegate.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false


        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
        _ = viewModel.art.subscribe(onNext: {n in
            self.art.image = n
        })

        let play$ = play.rx.tap
            .scan(false) { lastState, newValue in
                return !lastState }
        _ = play$.bindTo(viewModel.playing)
        _ = play$.bindTo(play.rx.isSelected)
        _ = play$.subscribe(onNext: {n in print(n) })

        let fastForward$ = fastForward.rx.tap
            .map { Jump.forward }

        let rewind$ = rewind.rx.tap
            .map { Jump.backward }

        _ = Observable.of(fastForward$, rewind$)
            .merge()
            .bindTo(viewModel.jump)


        let touchDownFastForward$ = fastForward.rx.controlEvent(.touchDown)
        let touchDownRewind$ = rewind.rx.controlEvent(.touchDown)

        let touchUpFastForward$ = Observable.of(fastForward.rx.controlEvent(.touchUpInside), fastForward.rx.controlEvent(.touchUpOutside))
        let touchUpRewind$ =
            Observable.of(rewind.rx.controlEvent(.touchUpInside), rewind.rx.controlEvent(.touchUpOutside))


        _ = Observable.combineLatest(touchDownFastForward$, touchDownRewind$) { return (ff: $0, rw: $1) }





    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
