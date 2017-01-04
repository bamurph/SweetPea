
//  SweetPea
//  Created by Ben Murphy on 12/28/16.
//
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation

enum AudioDownloadingError: Error {
    case invalidURL(String)
}

protocol AudioDownloading {
    func data(from url : URL) -> Observable<Data>
    func data(from enclosure: Enclosure)-> Observable<Data>
}


struct DownloadService {
    let disposeBag = DisposeBag()
}

extension DownloadService: AudioDownloading {

    func data(from enclosure: Enclosure) -> Observable<Data> {
        guard
            let url = URL(string: enclosure.url)
            else {
                return Observable.error(AudioDownloadingError.invalidURL(enclosure.url))
        }
        return url |> data
    }


    func data(from url: URL) -> Observable<Data> {
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
