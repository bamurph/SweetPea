//
//  AudioPlaybackViewController.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/23/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class AudioPlaybackViewController: UIViewController {
    let opml = try? OPMLService(with: Resources.demoURL!)

    override func viewDidLoad() {
        super.viewDidLoad()

        dump(opml?.items)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
