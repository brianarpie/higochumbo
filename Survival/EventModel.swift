//
//  EventModel.swift
//  Survival
//
//  Created by Brian Arpie on 9/3/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation

typealias Event = (
    eventId: Int64?,
    enemyActionId: Int64?,
    choiceA: String?,
    choiceB: String?,
    outcomeA: String?,
    outcomeB: String?
)