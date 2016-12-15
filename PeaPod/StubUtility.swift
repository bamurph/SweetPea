//
//  StubUtility.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/15/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift

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


// TODO: -
// - Create a dictionary that contains mappings of URLs to their contents
// - Persist this dictionary to disk for fast testing
// - Subclass FeedKit's FeedParser with a new init method that checks the dictionary's URLs & if it matches uses the local file
// - At this point we have a basic cache system... Should just build this with CoreData or Realm? 

// - Challenge: the first hit to any url will always be slow gbut can bge very fast after that - will this work best as an idempotent solution to tests - the first time a test hits this it'll be a bit slower, but every time after it'll be instant. Will keep average test speed up.





