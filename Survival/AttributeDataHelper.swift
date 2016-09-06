//
//  AttributeDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/5/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class AttributeDataHelper {
    static let attribute_id = Expression<Int64>("id")
    static let name = Expression<String>("name")
    static let display_name = Expression<String>("display_name")
    static let is_hero_attribute = Expression<Bool>("is_hero_attribute")
    static let is_real_attribute = Expression<Bool>("is_real_attribute")
    
    typealias T = Attribute
    static let attributes = Table("attributes")
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let expr = attributes.create { t in
                t.column(attribute_id, primaryKey: true)
                t.column(name)
                t.column(display_name)
                t.column(is_hero_attribute)
                t.column(is_real_attribute)
            }
            _ = try DB.run(expr)
        } catch _ {
            // Error thrown when table exists
            throw DataAccessError.Table_Create_Error
        }
    }
    
    
}