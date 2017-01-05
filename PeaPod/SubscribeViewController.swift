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
    let service = RSSService()
    let viewModel: FeedViewModel? = nil

    @IBOutlet weak var podcastUrl: UITextField!
    @IBOutlet weak var feedName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = podcastUrl.rx.text.orEmpty
            .map { URL(string: $0) }
            .filter { $0 != nil }
            .flatMapLatest { url in
                return self.service.performFetch(url!)}
            .subscribe(onNext: {n in
                switch n {
                case .Success(let feed):
                    self.feedName.text = feed.title ?? "No Title"

                case .Failure(let error):
                    self.feedName.text = "..."
                    print(error)
                }

            })




        //            .map { $0.title }
        //            .bindTo(feedName.rx.text)
        //            .flatMapLatest({ (url) -> Observable<RSSFeed> in
        //                return service.fetch(url: url)
        //            })
        //            .subscribe()
        //            .flatMap(ignoreNil)
        //            .flatMapLatest { self.service.fetch(url: $0) }
        //            .map { $0.title }
        //            .subscribe(onNext: {n in
        //                print(n)
        //            })



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
