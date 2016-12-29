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

    func deleteSubscription(subscription: Subscription) {
        do {
            try write {
                if subscription.feed != nil { delete(subscription.feed!) }
                delete(subscription)
            }

        } catch {
            print(StoreError.deleteSubscriptionFailed(error).localizedDescription)
        }
    }

    // MARK: -

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
        } catch (let error) {
            print(StoreError.addAudioFailed(error))
        }
    }

    // TODO: - finish delete audio
    func deleteAudio(for enclosure: Enclosure) {

    }

}




let store = try! Realm(fileURL: URL(string: "/Users/ben/Desktop/TestRealm.realm")!)

