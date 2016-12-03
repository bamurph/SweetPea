//
//  ViewController.swift
//  PeaPod
//
//  Created by Ben Murphy on 11/10/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
    let service = AudioService()
    var player: AVPlayer!

    @IBOutlet var tap: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        service
            .audioPlayer(url: urls[0])
            .subscribe(onNext: { n in
                self.player = n
                print("about to play")
                self.player.play()
                print("should be playing")
            })


        tap.rx.event
            .throttle(0.2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                print(self?.player.currentTime().seconds)
            })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

