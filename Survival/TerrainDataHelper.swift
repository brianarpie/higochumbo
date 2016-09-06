//
//  TerrainDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/5/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class TerrainDataHelper {
    static let terrain_id = Expression<Int64>("id")
    static let name = Expression<String>("name")
    static let display_name = Expression<String>("display_name")
    static let image_url = Expression<String>("image_url")
    
    typealias T = Terrain
    static let terrains = Table("terrains")
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let expr = terrains.create { t in
                t.column(terrain_id, primaryKey: true)
                t.column(name)
                t.column(display_name)
                t.column(image_url)
            }
            _ = try DB.run(expr)
        } catch _ {
            // Error thrown when table exists
            throw DataAccessError.Table_Create_Error
        }
    }
    
    
}