//
//  OutcomeDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/5/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class OutcomeDataHelper {
    static let outcome_id = Expression<Int64>("id")
    static let text = Expression<String>("text")
    static let event_id = Expression<Int64>("event_id")
    
    typealias T = Outcome
    static let outcomes = Table("outcomes")
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let expr = outcomes.create { t in
                t.column(outcome_id, primaryKey: true)
                t.column(text)
                t.column(event_id)
                t.foreignKey(event_id, references: EventDataHelper.events, EventDataHelper.event_id, delete: .Cascade)
            }
            _ = try DB.run(expr)
        } catch _ {
            // Error thrown when table exists
            throw DataAccessError.Table_Create_Error
        }
    }
    
}