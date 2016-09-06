//
//  EnemyDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/5/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class EnemyDataHelper {
    static let enemy_id = Expression<Int64>("id")
    static let name = Expression<String>("name")

    typealias T = Enemy
    static let enemies = Table("enemies")
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let expr = enemies.create { t in
                t.column(enemy_id, primaryKey: true)
                t.column(name)
            }
            _ = try DB.run(expr)
        } catch _ {
            // Error thrown when table exists
            throw DataAccessError.Table_Create_Error
        }
    }


}