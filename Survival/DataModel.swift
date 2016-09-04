//
//  DataModel.swift
//  Survival
//
//  Created by Brian Arpie on 8/27/16.
//  Copyright © 2016 Parsed Cache Studios. All rights reserved.
//

import Foundation

enum Positions: String {
    case Pitcher = "Pitcher"
    case Catcher = "Catcher"
    case FirstBase = "First Base"
    case SecondBase = "Second Base"
    case ThirdBase = "Third Base"
    case Shortstop = "Shortstop"
    case LeftField = "Left Field"
    case CenterField = "Center Field"
    case RightField = "Right field"
    case DesignatedHitter = "Designated Hitter"
}

typealias Team = (
    teamId: Int64?,
    city: String?,
    nickName: String?,
    abbreviation: String?
)

typealias Player = (
    playerId: Int64?,
    firstName: String?,
    lastName: String?,
    number: Int?,
    teamId: Int64?,
    position: Positions?
)