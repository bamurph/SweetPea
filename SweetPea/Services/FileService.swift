//
//  FileService.swift
//  SweetPea
//
//  Created by Ben Murphy on 2/2/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift

protocol FileWriting {
    func fileUrl() -> URL
    func write(data: Observable<(name: String, data: Data)>) -> Observable<(path: String, data: Data)>
}

extension FileWriting {
    func fileUrl() -> URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    internal func write(data: Observable<(name: String, data: Data)>) -> Observable<(path: String, data: Data)> {

        return Observable.create { observer in
            let data$ = data
                .map { (url: self.fileUrl().appendingPathComponent($0.name),
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
