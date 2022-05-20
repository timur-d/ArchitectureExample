//
// Created by Mikhail Mulyar on 20.05.2022.
//

import RealmSwift
import Foundation


public typealias PersistableEnum = RealmSwift.PersistableEnum


public class DatabaseSetup {
    public static func setupDatabase() {
        let currentSchemaVersion: UInt64 = 0
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: currentSchemaVersion,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: {
                newVersion, oldSchemaVersion in

                // first install migration
                if oldSchemaVersion < 1 {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            },
            deleteRealmIfMigrationNeeded: false)

        //        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupDomainName)
        //        let realmURL = container?.appendingPathComponent("database.realm")
        //        config.fileURL = realmURL

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config

        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        do {
            _ = try Realm()
        } catch let error {
            print("Failed to open Realm - \(error)")
        }
    }
}
