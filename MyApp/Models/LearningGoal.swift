//
//  LearningGoal.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//
import Foundation

struct LearningGoal: Hashable{ // why struct? cause it just holds values and has no behavior of its own.
    var subject: String  //users goal
    var duration: LearningDuration // the type made in learningduration.swift
    var startDate: Date = Date() //Date() is a default value meaning “right now”
}
