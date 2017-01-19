//
//  Migrations.swift
//  SweetPea
//
//  Created by Ben Murphy on 1/12/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import Foundation
import RealmSwift

struct Migrations {
    static func run() {
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Subscription.className(), { (oldObject, newObject) in
                        newObject!["primaryKeyProperty"] = "xmlUrl"
                    })
                }

                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: Feed.className(), { (old, new) in
                        new!["primaryKeyProperty"] = "link"
                    })
                }

                if oldSchemaVersion < 3 {
                    migration.enumerateObjects(ofType: Feed.className(), { (old, new) in
                        new!["primaryKeyProperty"] = "link"
                    })

                    migration.enumerateObjects(ofType: Episode.className(), { (old, new) in
                        new!["primaryKeyProperty"] = "link"
                    })

                    migration.enumerateObjects(ofType: Enclosure.className(), { (old, new) in
                        new!["primaryKeyProperty"] = "url"
                    })
                }

        })

        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()

    }
}
