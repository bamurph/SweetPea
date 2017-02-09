//
//  RootViewModel.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/16/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RootViewModel: FileLocating, FileReading {

    // MARK: - Dependencies
    private let disposeBag = DisposeBag()
    private let rssService = RSSService()

    // MARK: - Model
    let episodes: Observable<Episode>
    let feeds: Observable<Feed>

    init() {
        feeds = Observable.from(store().feeds |> Array.init)
        episodes = Observable.from(store().episodes |> Array.init)

        _ = refresh(oldFeeds: feeds)


    }

    func feedsWithImages() -> Observable<(Feed, UIImage?)> {
        let imagesForFeeds$ = feeds
            .map { feed -> URL? in
                guard
                    let path = feed.imageLocalUrl
                    else { return nil }
                return self.fileDir().appendingPathComponent(path)}
            .flatMap { url -> Observable<UIImage?> in
                guard
                    url != nil
                    else { return .just(nil) }
                return self.image(at: url!)
                    .map { UIImage?.some($0) }}

        return Observable
            .zip(feeds, imagesForFeeds$) { return ($0, $1) }
            .map { ($0.0, $0.1) }
    }

    func episodesWithImages() -> Observable<(Episode, UIImage?)> {
        return Observable
            .combineLatest(episodes,
                           feedsWithImages().toArray()) { ($0, $1) }
            .map { (ep, fds) in
                let match = fds.first(where: { (feed, image) -> Bool in
                    feed == ep.feed.first
                })
                guard
                    match != nil
                    else { return (ep, nil) }
                return (ep, match!.1)
        }
    }

    func sortedWithImages() -> Observable<[(Episode, UIImage?)]> {
        return episodesWithImages()
            .scan([(Episode, UIImage?)]()) { eps, e in
                return eps + [e] }
            .map {
                $0.sorted(by: { (a, b) -> Bool in
                    switch (a.0.pubDate, b.0.pubDate) {
                    case let (.some(val1), .some(val2)): return val1 > val2
                    default: return false
                    }
                })
        }

    }




    func refresh(oldFeeds: Observable<Feed>) -> Disposable {
        return oldFeeds
            .subscribe(onNext: {n in
                self.rssService.refresh(n)
            }, onCompleted: {c in
                print("Feeds are refreshed!")
            })
    }
}
