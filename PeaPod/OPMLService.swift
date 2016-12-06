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

struct OPMLService {

    let url: URL
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


    func items(from: URL) -> Observable<[Item]> {
        return self
            .fetchedFile(from: url)
            .flatMap { self.items(from: $0) }
    }
    
    
}
