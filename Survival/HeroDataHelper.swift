//
//  HeroDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/3/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class HeroDataHelper {
    static let TABLE_NAME = "hero"
    
    static let heroId = Expression<Int64>("id")
    static let level = Expression<Int64>("level")
    
    
    static let table = Table(TABLE_NAME)
    
    typealias T = Hero
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                
                t.column(heroId, primaryKey: true)
                t.column(level)
                
                })
        } catch _ {
            // Error thrown when table exists
            print("table already exists")
        }
    }
    static func createHero() throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let insert = table.insert(level <- 1)
        do {
            let rowId = try DB.run(insert)
            guard rowId >= 0 else {
                throw DataAccessError.Insert_Error
            }
            return rowId
        } catch _ {
            throw DataAccessError.Insert_Error
        }
    }
}
