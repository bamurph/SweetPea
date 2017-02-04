//
//  FileService.swift
//  SweetPea
//
//  Created by Ben Murphy on 2/2/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift


protocol FileLocating {
    func fileDir() -> URL
}
protocol FileWriting: FileLocating {
    func write(data: Observable<(name: String, data: Data)>) -> Observable<(path: String, data: Data)>
}

protocol FileReading: FileLocating {
    func data(at url: URL) -> Observable<Data>
    func image(at url: URL) -> Observable<UIImage>
}

enum FileReadingErrors: Error {
    case couldNotConvertDataToImage
}
extension FileLocating {
    func fileDir() -> URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

}

extension FileWriting {
    internal func write(data: Observable<(name: String, data: Data)>) -> Observable<(path: String, data: Data)> {

        return Observable.create { observer in
            let data$ = data
                .map { (url: self.fileDir().appendingPathComponent($0.name),
                        data: $0.data) }
                .subscribe(onNext: { n in
                    do {
                        try n.data.write(to: n.url, options: .atomic)
                        observer.onNext((path: n.url.absoluteString, data: n.data))
                    } catch let error {
                        observer.onError(error)
                    }
                })
        return data$
        }
    }

}

extension FileReading {

    internal func data(at url: URL) -> Observable<Data> {
        return Observable<Data>.create { observer in

            do {
                let data = try Data.init(contentsOf: url, options: [])
                observer.onNext(data)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
        return Disposables.create()
        }
    }

    internal func image(at url: URL) -> Observable<UIImage> {
       return data(at: url)
            .flatMap  { data -> Observable<UIImage> in
                if let image = UIImage.init(data: data) {
                    return .just(image)
                } else {
                    return .error(FileReadingErrors.couldNotConvertDataToImage)
                }
        }

    }

}
