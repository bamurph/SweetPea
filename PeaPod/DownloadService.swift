//
//  DownloadService.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/28/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation

protocol AudioDownloading {
    func dataFromURL(_ url: URL) -> Observable<Data>
}

struct DownloadService: AudioDownloading {

    let disposeBag = DisposeBag()

    func dataFromURL(_ url: URL) -> Observable<Data> {
        return Observable<Data>.create { observer in

            do {
                let data = try Data(contentsOf: url)
                observer.onNext(data)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

