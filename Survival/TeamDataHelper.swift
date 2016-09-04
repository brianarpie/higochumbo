//
//  TeamDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 8/22/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class TeamDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "Teams"
    
    static let table = Table(TABLE_NAME)
    static let teamId = Expression<Int64>("teamid")
    static let city = Expression<String>("city")
    static let nickName = Expression<String>("nickname")
    static let abbreviation = Expression<String>("abbreviation")
    
    typealias T = Team
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) { t in
                t.column(teamId, primaryKey: true)
                t.column(city)
                t.column(nickName)
                t.column(abbreviation)
            })
        } catch _ {
            // Error throw if table already exists
        }
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.city != nil && item.nickName != nil && item.abbreviation != nil) {
            let insert = table.insert(city <- item.city!, nickName <- item.nickName!, abbreviation <- item.abbreviation!)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                throw DataAccessError.Nil_In_Data
            }
        }
        throw DataAccessError.Nil_In_Data
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let id = item.teamId {
            let query = table.filter(teamId == id)
            do {
                let tmp = try DB.run(query.delete())
                guard tmp == 1 else {
                    throw DataAccessError.Delete_Error
                }
            } catch _ {
                throw DataAccessError.Delete_Error
            }
        }
    }
    static func deleteAll() throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let items = try DB.prepare(table)
        for item in items {
            let query = table.filter(teamId == item[teamId])
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                throw DataAccessError.Delete_Error
            }
        }
    }
    
    static func find(id: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(teamId == id)
        let items = try DB.prepare(query)
        for item in  items {
            return Team(teamId: item[teamId] , city: item[city], nickName: item[nickName], abbreviation: item[abbreviation])
        }
        
        return nil
        
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(Team(teamId: item[teamId], city: item[city], nickName: item[nickName], abbreviation: item[abbreviation]))
        }
        
        return retArray
        
    }
}