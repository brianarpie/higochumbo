//
//  EventDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/5/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class EventDataHelper {
    static let event_id = Expression<Int64>("id")
    static let choice_a = Expression<String>("choice_a")
    static let choice_b = Expression<String>("choice_b")
    static let outcome_a = Expression<String>("outcome_a")
    static let outcome_b = Expression<String>("outcome_b")
    static let enemy_action_id = Expression<Int64?>("enemy_action_id")

    typealias T = Event
    static let events = Table("events")
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let expr = events.create { t in
                t.column(event_id, primaryKey: true)
                t.column(choice_a)
                t.column(choice_b)
                t.column(outcome_a)
                t.column(outcome_b)
                t.column(enemy_action_id)
                t.foreignKey(enemy_action_id, references: EnemyActionDataHelper.enemy_actions, EnemyActionDataHelper.enemy_action_id, delete: .Cascade)
            }
            _ = try DB.run(expr)
        } catch _ {
            // Error thrown when table exists
            throw DataAccessError.Table_Create_Error
        }
    }


}