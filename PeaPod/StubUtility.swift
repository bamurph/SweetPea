//
//  StubUtility.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/15/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import Realm

enum StubUtilityError: Error {
    case noContentAtURL(url: RSSUrl)
}
func content(at url: RSSUrl) -> Observable<[RSSUrl: String]> {
    let urlRequest = URLRequest(url: url)
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)

    return Observable.create { observer in
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error != nil else {
                return observer.onError(error!) }
            let content = String(data: data!, encoding: String.Encoding.utf8)

            guard content != nil else {
                return observer.onError(StubUtilityError.noContentAtURL(url: url)) }
            observer.onNext([url: content!])
            observer.onCompleted()
        }

        task.resume()
        return Disposables.create()
    }

}







