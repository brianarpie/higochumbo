//
//  ItemModel.swift
//  Survival
//
//  Created by Brian Arpie on 9/3/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation

typealias Item = (
    itemId: Int64?,
    name: String?,
    displayName: String?,
    description: String?,
    levelRequired: Int64?,
    price: Int64?,
    imageUrl: String?,
    heroId: Int64?
)