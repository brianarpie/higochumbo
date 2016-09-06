//
//  EnemyActionDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/5/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class EnemyActionDataHelper {
    static let enemy_action_id = Expression<Int64>("id")
    static let enemy_id = Expression<Int64>("enemy_id")
    static let text = Expression<String>("text")

    typealias T = EnemyAction
    static let enemy_actions = Table("enemy_actions")
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let expr = enemy_actions.create { t in
                t.column(enemy_action_id, primaryKey: true)
                t.column(text)
                t.column(enemy_id)
                t.foreignKey(enemy_id, references: EnemyDataHelper.enemies, EnemyDataHelper.enemy_id, delete: .Cascade)
            }
            _ = try DB.run(expr)
        } catch _ {
            // Error thrown when table exists
            throw DataAccessError.Table_Create_Error
        }
    }


}