//
//  SQLiteDataStore.swift
//  Survival
//
//  Created by Brian Arpie on 8/22/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: ErrorType {
    case Datastore_Connection_Error
    case Table_Create_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}

class SQLiteDataStore {
    static let sharedInstance = SQLiteDataStore()
    let BBDB: Connection?
    
    private init() {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        print (path)
        
        do {
            BBDB = try Connection("\(path)/db.sqlite3")
        } catch _ {
            BBDB = nil
        }
        
    }
    
    func createTables() throws{
        do {
            try HeroDataHelper.createTable()
            try ItemDataHelper.createTable()
        } catch {
            throw DataAccessError.Datastore_Connection_Error
        }
    }
    
}
