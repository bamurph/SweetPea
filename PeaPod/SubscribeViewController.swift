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
    let viewModel = SubscribeViewModel()

    @IBOutlet weak var podcastUrl: UITextField!

    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var feedDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        podcastUrl.rx.text
            .subscribe(onNext: { n in
                self.viewModel.urlText.value = n ?? ""
            }).addDisposableTo(disposeBag)

        viewModel.podcastTitle
            .bindTo(feedTitle.rx.text)
            .addDisposableTo(disposeBag)

        viewModel.podcastDescription
            .bindTo(feedDescription.rx.text)
            .addDisposableTo(disposeBag)



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
