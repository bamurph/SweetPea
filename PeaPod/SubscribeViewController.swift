//
//  SubscribeViewController.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/4/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import FeedKit

class SubscribeViewController: UIViewController {
    let disposeBag = DisposeBag()
    let rssService = RSSService()

    @IBOutlet weak var podcastUrl: UITextField!
    @IBOutlet weak var feedName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let response = podcastUrl.rx.text
            .distinctUntilChanged()
            .debug()
            .map { URL(string: $0) }



//
//        response
//            .map { $0.title ?? "--" }
//            .bindTo(feedName.rx.text)
//            .addDisposableTo(disposeBag)


    }
    // Do any additional setup after loading the view.


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
