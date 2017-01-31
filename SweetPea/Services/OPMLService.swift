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

public typealias OPMLItem = Item
public typealias OPMLUrl = URL

protocol OPMLProtocol {
    func items(from url: OPMLUrl) -> Observable<[OPMLItem]>
}


struct OPMLService: OPMLProtocol {

    let disposeBag = DisposeBag()

    func fetchedFile(from url: OPMLUrl) -> Observable<String> {
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

    func extractedItems(from file: Observable<String>) -> Observable<[OPMLItem]> {
        return Observable<[Item]>.create { observer in
            file.subscribe(onNext: { contents  in
                let parser = Parser(text: contents)
                    .success {
                        observer.onNext($0)
                        observer.onCompleted()
                    }
                    .failure {
                        observer.onError($0)
                }

                parser.main()
            })
        }
    }


    func items(from url: OPMLUrl) -> Observable<[OPMLItem]> {
        return url |> fetchedFile |> extractedItems
    }



    func withFeedURLs(from items: Observable<[OPMLItem]>) -> Observable<[OPMLItem]> {
        return items.map {
            $0.filter {
                $0.xmlURL != nil || URL(string: $0.xmlURL!) != nil
            }
        }
    }

    func rssUrls(items: Observable<[OPMLItem]>) -> Observable<[RSSUrl]> {
        let itemsWithURLs = items |> withFeedURLs
        return itemsWithURLs.map {
            $0.map {
                URL(string: $0.xmlURL!)!
            }
        }
    }

    func rssUrls(url: OPMLUrl) -> Observable<[RSSUrl]> {
        return url |> items |> rssUrls
    }
}





