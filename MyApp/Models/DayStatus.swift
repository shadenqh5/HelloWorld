//
//  DayStatus.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//

import Foundation

enum DayStatus { // what happened on a given day, the week strip and the calendar both use it
    case none
    case learned
    case frozen
}

enum GoalStatus { // where the goal currently stands
    case active
    case completed
    case failed
}
