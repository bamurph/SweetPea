
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
    func data(from url: URL) -> Observable<Data>
    func data(from enclosure: Enclosure)-> Observable<Data>
}

enum ImageDownloadingError: Error {
    case noImageCreated
    case invalidURL(String)
    case noData
    case noPath
}

protocol ImageDownloading {
    func image(from url: URL) -> Observable<UIImage>
    func data(from url: URL) -> Observable<Data>
    func data(from path: String?) -> Observable<Data>
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

extension DownloadService: ImageDownloading {

    internal func data(from path: String?) -> Observable<Data> {
        let data$ = Observable.of(path)
            .flatMap { p -> Observable<Data> in
                guard
                    let path = p,
                    let url = URL(string: path)
                    else { return Observable.empty() }
                do {
                    let data = try Data(contentsOf: url)
                    return Observable.just(data)
                } catch let error {
                    return Observable.error(error)
                }
        }
        return data$
    }


    internal func image(from url: URL) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    observer.onNext(image)
                    observer.onCompleted()
                } else {
                    observer.onError(ImageDownloadingError.noImageCreated)
                }
            } catch {
                observer.onError(ImageDownloadingError.invalidURL(url.absoluteString))
            }
            return Disposables.create()
        }
    }



}
