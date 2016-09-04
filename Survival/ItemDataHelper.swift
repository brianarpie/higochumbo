//
//  ItemDataHelper.swift
//  Survival
//
//  Created by Brian Arpie on 9/3/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

class ItemDataHelper {
    static let _item_id = Expression<Int64>("id")
    static let _hero_id = Expression<Int64?>("hero_id")
    static let _name = Expression<String>("name")
    static let _display_name = Expression<String>("display_name")
    static let _description = Expression<String>("description")
    static let _level_required = Expression<Int64>("level_required")
    static let _price = Expression<Int64>("price")
    static let _image_url = Expression<String?>("image_url")
    
    static let items = Table("items")
    
    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do {
            let expr = items.create { t in
                t.column(_item_id, primaryKey: true)
                t.column(_name)
                t.column(_display_name)
                t.column(_description)
                t.column(_level_required)
                t.column(_price)
                t.column(_image_url, defaultValue: "hello world")
                t.column(_hero_id)
                t.foreignKey(_hero_id, references: HeroDataHelper.table, HeroDataHelper.heroId, update: .Cascade, delete: .Cascade)
            }
            print(expr.asSQL())
            _ = try DB.run(expr)
        } catch _ {
            // Error thrown when table exists
            print("ERROR: unable to create items table")
        }
    }
    static func insert(name:String, display_name:String, description:String, level_required:Int64, price:Int64, image_url:String? = nil) throws -> Int64 {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let insert = items.insert(
            _name           <- name,
            _display_name   <- display_name,
            _description    <- description,
            _level_required <- level_required,
            _price          <- price,
            _image_url      <- image_url
        )
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
    static func update_hero_id(item_id: Int64, hero_id: Int64) throws -> Void {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        try DB.transaction {
            let item = items.filter(_item_id == item_id)
            try DB.run(item.update(_hero_id <- hero_id))
        }
    }
    static func all() throws -> [AnyObject] {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray:[AnyObject] = []
        try DB.transaction {
            let query = items.select(items[*])
            for item in try DB.prepare(query) {
                retArray.append("\(item[_name]),\(item[_display_name]),\(item[_hero_id])")
            }
        }
        return retArray
    }
}