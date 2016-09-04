//
//  PlayerDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 8/27/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class PlayerDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "Players"
    
    static let playerId = Expression<Int64>("playerid")
    static let firstName = Expression<String>("firstName")
    static let lastName = Expression<String>("lastName")
    static let number = Expression<Int>("number")
    static let teamId = Expression<Int64>("teamid")
    static let position = Expression<String>("position")
    
    
    static let table = Table(TABLE_NAME)
    
    typealias T = Player
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                
                t.column(playerId, primaryKey: true)
                t.column(firstName)
                t.column(lastName)
                t.column(number)
                t.column(teamId)
                t.column(position)
                
                })
        } catch _ {
            // Error thrown when table exists
        }
    }
    
    static func insert(item: T) throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.firstName != nil && item.lastName != nil && item.teamId != nil && item.position != nil) {
            let insert = table.insert(firstName <- item.firstName!, number <- item.number!, lastName <- item.lastName!, teamId <- item.teamId!, position <- item.position!.rawValue)
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
        throw DataAccessError.Nil_In_Data
    }
    
    static func delete (item: T) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let id = item.playerId {
            let query = table.filter(playerId == id)
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
            let query = table.filter(playerId == item[playerId])
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
        let query = table.filter(playerId == id)
        let items = try DB.prepare(query)
        for item in  items {
            return Player(playerId: item[playerId], firstName: item[firstName], lastName: item[lastName], number: item[number], teamId: item[teamId], position: Positions(rawValue: item[position]))
        }
        
        return nil
        
    }
    
    static func findByTeamId(_teamId: Int64) throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let query = table.filter(teamId == _teamId)
        let items = try DB.prepare(query)
        for item in items {
            retArray.append(Player(playerId: item[playerId], firstName: item[firstName], lastName: item[lastName], number: item[number], teamId: item[teamId], position: Positions(rawValue: item[position])))
        }
        return retArray
    }
    
    static func findAll() throws -> [T]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(Player(playerId: item[playerId], firstName: item[firstName], lastName: item[lastName], number: item[number], teamId: item[teamId], position: Positions(rawValue: item[position])))
        }
        
        return retArray
    }
}