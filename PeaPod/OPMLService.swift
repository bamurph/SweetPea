//
//  OPMLService.swift
//  SweetPea
//
//  Created by Ben Murphy on 11/10/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import FeedKit
import RxSwift
import Lepton

struct OPMLService: OPMLProtocol {

    let disposeBag = DisposeBag()


    func fetchedFile(from url: URL) -> Observable<String> {
        return Observable<String>.create { observer in
            do {
                let string = try String(contentsOf: url, encoding: String.Encoding.utf8)
                observer.onNext(string)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func items(from file: String) -> Observable<[Item]> {
        return Observable<[Item]>.create { observer in
            let parser = Parser(text: file)
                .success {
                    observer.onNext($0)
                    observer.onCompleted()
                }
                .failure {
                    observer.onError($0)
            }

            parser.main()
            return Disposables.create()
        }
    }


    func items(from url: URL) -> Observable<[Item]> {
        return self
            .fetchedFile(from: url)
            .flatMap { self.items(from: $0) }
    }


    func withFeedURLs(from items: [Item]) -> [Item] {
        return items.filter { $0.xmlURL != nil }
    }

    func rssURLs(from items: [Item]) -> [URL] {
        return items.flatMap { URL(string: $0.xmlURL!) ?? nil }
    }

    let feedsFromUrls = withFeedURLs
}





