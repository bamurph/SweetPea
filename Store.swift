//
//  Store.swift
//  SweetPea
//
//  Created by Ben Murphy on 12/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum StoreError: Error {
    case addSubscriptionFailed(Error)
    case deleteSubscriptionFailed(Error)
    case addAudioFailed(Error)
    case deleteAudioFailed(Error)
    case addEnclosureFailed(Error)
    case deleteEnclosureFailed(Error)
}

extension Realm {
    var subscriptions: Results<Subscription> {
        return objects(Subscription.self)
    }

    var feeds: Results<Feed> {
        return objects(Feed.self)
    }

    var episodes: Results<Episode> {
        return objects(Episode.self)
    }

    var enclosures: Results<Enclosure> {
        return objects(Enclosure.self)
    }

    var audioData: Results<Audio> {
        return objects(Audio.self)
    }
}

// MARK: Actions

extension Realm {
    // MARK: Subscription Actions
    func addSubscription(title: String, summary: String?, xmlUrl: String, htmlUrl: String?, feed: Feed?) {
        do {
            try write {
                let sub = Subscription()
                sub.title = title
                sub.summary = summary
                sub.xmlUrl = xmlUrl
                sub.htmlUrl = htmlUrl
                add(sub)
            }
        } catch {
            print(StoreError.addSubscriptionFailed(error).localizedDescription)
        }
    }

    func deleteSubscription(_ subscription: Subscription) {
        do {
            try write {
                if let feeds = subscription.feed { delete(feeds) }
                delete(subscription)
            }
        } catch {
            print(StoreError.deleteSubscriptionFailed(error).localizedDescription)
        }
    }

    // MARK: Enclosure Actions
    func addEnclosure(url: String, type: String, length: Int64?) {
        do {
            try write {
                let enc = Enclosure()
                enc.url = url
                enc.type = type
                enc.length.value = length
                add(enc)
            }
        } catch  {
            print(StoreError.addEnclosureFailed(error))
        }
    }


    func deleteEnclosure(_ enclosure: Enclosure) {
        do {
            try write {
                delete(enclosure.localAudio)
                delete(enclosure)
            }
        } catch {
            print(StoreError.addEnclosureFailed(error))
        }
    }




    // MARK: Audio Actions
    func addAudio(for enclosure: Enclosure) {
        do {
            try write {
                let svc = DownloadService()

                let _ = svc.data(from: enclosure)
                    .subscribe(
                        onNext: { data in
                            let audio = Audio()
                            audio.enclosure = enclosure
                            audio.file = data
                            self.add(audio) },
                        onError: { error in
                            print(StoreError.addAudioFailed(error)) })
            }
        } catch {
            print(StoreError.addAudioFailed(error))
        }
    }


    func deleteAudio(_ audio: Audio) {
        do {
            try write {
                delete(audio)
            }
        } catch {
            print(StoreError.deleteAudioFailed(error))
        }
    }
    
}




let store = try! Realm(fileURL: URL(string: "/Users/ben/Desktop/TestRealm.realm")!)

