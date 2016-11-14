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

class OPMLService {

    let url: URL
    let items: Observable<[Item]>
    let disposeBag = DisposeBag()

    init(with url: URL) throws {
        self.url = url
        self.items = OPMLService.fetchedFile(from: url)
            .catchError { e in
                throw e
            }
            .flatMapLatest { s in
                OPMLService.parsedItems(from: s)
                    .catchError { e in
                        throw e
                }
        }

        
    }

    static func fetchedFile(from url: URL) -> Observable<String> {
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

    static func parsedItems(from file: String) -> Observable<[Item]> {
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
    
    
    
    
    
}
