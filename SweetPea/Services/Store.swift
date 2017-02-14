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
import FeedKit

enum StoreError: Error {
    case addSubscriptionFailed(Error)
    case deleteSubscriptionFailed(Error)
    case addFeedFailed(Error)
    case addFeedImageFailed(Error)
    case deleteFeedFailed(Error)
    case addEpisodeFailed(Error)
    case deleteEpisodeFailed(Error)
    case addAudioFailed(Error)
    case deleteAudioFailed(Error)
    case addEnclosureFailed(Error)
    case deleteEnclosureFailed(Error)
}
extension Realm: FileWriting {}

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


// MARK: - Subscription Actions
extension Realm {

    func addSubscription(title: String, summary: String?, xmlUrl: String, htmlUrl: String?, feed: Feed?) {
        do {
            try write {
                let sub = Subscription()
                sub.title = title
                sub.summary = summary
                sub.xmlUrl = xmlUrl
                sub.htmlUrl = htmlUrl
                sub.feed = feed

                add(sub, update: true)
            }

        } catch {
            print(StoreError.addSubscriptionFailed(error).localizedDescription)
        }
    }

    func deleteSubscription(_ subscription: Subscription) {
        do {
            try write {
                if let feed = subscription.feed { feed |> deleteFeed }
                delete(subscription)
            }
        } catch {
            print(StoreError.deleteSubscriptionFailed(error).localizedDescription)
        }
    }

}

// MARK: - Feed Actions
extension Realm {


    func refresh(_ feed: Feed) {
        self.addFeed(feed)
    }

    func addFeed(_ feed: Feed) {
        self.addFeed(title: feed.title, link: feed.link, feedDescription: feed.feedDescription, language: feed.language, copyright: feed.copyright, managingEditor: feed.managingEditor, webMaster: feed.webMaster, pubDate: feed.pubDate, lastBuildDate: feed.lastBuildDate, imageUrl: feed.imageUrl, imageLocalUrl: feed.imageLocalUrl, categories: feed.joinedCategories(), items: feed.items)
    }

    func addFeed(title: String, link: String, feedDescription: String?, language: String?, copyright: String?, managingEditor: String?, webMaster: String?, pubDate: Date?, lastBuildDate: Date?, imageUrl: String?, imageLocalUrl: String?, categories: String?, items: List<Episode> = List<Episode>.init()) {
        do {
            try write {
                let feed = Feed()
                feed.title = title
                feed.link = link
                feed.feedDescription = feedDescription
                feed.language = language
                feed.copyright = copyright
                feed.managingEditor = managingEditor
                feed.webMaster = webMaster
                feed.pubDate = pubDate
                feed.lastBuildDate = lastBuildDate
                feed.imageUrl = imageUrl
                feed.imageLocalUrl = imageLocalUrl
                feed.items = items
                feed.categories = feed.separated(categories)
                add(feed, update: true)
            }
        } catch {
            print(StoreError.addFeedFailed(error))
        }

    }

    func addFeedImage(_ feed: Feed) {

        let data$ = DownloadService().data(from: feed.imageUrl)
            .filter { _ in feed.imageUrl != nil }
            .map { (URL(string: feed.imageUrl!), $0 ) }
            .filter { $0.0 != nil }
            .map { (name: $0.0!.lastPathComponent, data: $0.1 ) }


        _ = write(data: data$)
            .subscribe(onNext: { n in
                do {
                    try self.write {
                        feed.imageLocalUrl = n.path
                    }
                } catch {
                }
            })


    }

    func deleteFeed(_ feed: Feed) {
        do {
            try write {
                feed.items.forEach { $0 |> deleteEpisode }
                delete(feed)

            }
        } catch {
            print(StoreError.deleteFeedFailed(error))
        }
    }

}

// MARK: - Episode Actions
extension Realm {
    func addEpisode(title: String, guid: String?, link: String, episodeDescription: String?, pubDate: Date?, enclosure: Enclosure) {
        do {
            try write {
                let episode = Episode()
                episode.title = title
                episode.guid = guid
                episode.link = link
                episode.episodeDescription = episodeDescription
                episode.pubDate = pubDate
                episode.enclosure = enclosure
                add(episode)
            }
        } catch {
            print(StoreError.addEpisodeFailed(error))
        }
    }

    func deleteEpisode(_ episode: Episode) {
        do {
            try write {
                if let enc = episode.enclosure { enc |> deleteEnclosure }
                delete(episode)
            }
        } catch {
            print(StoreError.deleteEpisodeFailed(error))
        }
    }
}

// MARK: - Enclosure Actions
extension Realm {
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
}



// MARK: - Audio Actions
extension Realm {
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




func store() -> Realm {
    if let _ = NSClassFromString("QuickSpec") {
        return try! Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "testing", syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, objectTypes: nil))
    }

    return try! Realm(fileURL: URL(string: "/Users/ben/Desktop/TestRealm.realm")!)
}
