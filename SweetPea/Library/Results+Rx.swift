//
//  Results+Rx.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/31/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

extension Results {

    /// Creates an observable sequence of realm Results objects. Sends the results once at query and again every time a change occurs.
    ///
    /// - Returns: Observable sequence of Results
    func asObservable() -> Observable<Results<Element>> {
        return Observable.create { observer in
            var token: NotificationToken? = nil

            token = self.addNotificationBlock { changes in
                switch changes {
                case .initial(let vals):
                    observer.onNext(vals)
                case .update(let updatedVals, _, _, _):
                    observer.onNext(updatedVals)
                case .error(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                token?.stop()
            }
        }
    }

    /// Creates an observable sequence of arrays of elements. Sends the results once at query and again every time a change occurs.
    ///
    /// - Returns: Observable sequence of arrays
    func asObservableArray() -> Observable<[Element]> {
        return Observable.create { observer in
            var token: NotificationToken? = nil

            token = self.addNotificationBlock { changes in
                switch changes {
                case .initial(let vals):
                    observer.onNext(Array(vals))
                case .update(let updatedVals, _, _, _):
                    observer.onNext(Array(updatedVals))
                case .error(let error):
                    observer.onError(error)
                }

            }
            return Disposables.create {
                token?.stop()
            }
        }

    }
}
