//
//  DataHelperProtocol.swift
//  Survival
//
//  Created by Brian Arpie on 8/27/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

protocol DataHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(item: T) throws -> Int64
    static func delete(item: T) throws -> Void
    static func find(id: Int64) throws -> T?
    static func findAll() throws -> [T]?
}
