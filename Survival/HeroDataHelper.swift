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
    
    static let _hero_id = Expression<Int64>("id")
    static let _level = Expression<Int64>("level")
    
    static let table = Table(TABLE_NAME)
    
    typealias T = Hero
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                
                t.column(_hero_id, primaryKey: true)
                t.column(_level)
                
                })
        } catch _ {
            // Error thrown when table exists
            print("table already exists")
        }
    }
    static func deleteAll() throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let items = try DB.prepare(table)
        for item in items {
            let query = table.filter(_hero_id == item[_hero_id])
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                throw DataAccessError.Delete_Error
            }
        }
    }
    static func createHero() throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let insert = table.insert(_level <- 1) // default level to 1
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
