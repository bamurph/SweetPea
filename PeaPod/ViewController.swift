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



    override func viewDidLoad() {
        super.viewDidLoad()

        _ =  service
            .audioPlayer(url: urls[0])
            .subscribe(onNext: { n in
                self.player = n
                self.player.play()
            })





    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

