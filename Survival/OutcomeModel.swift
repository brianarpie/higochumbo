//
//  OutcomeModel.swift
//  Survival
//
//  Created by Brian Arpie on 9/5/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation
import SQLite

typealias Outcome = (
    outcomeId: Int64?,
    text: String?,
    eventId: Int64?
)