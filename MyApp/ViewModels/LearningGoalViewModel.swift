//
//  LearningGoalViewModel.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//


import Foundation
import Combine

class LearningGoalViewModel: ObservableObject {
    @Published var subject: String // starts with the current goal's text
    @Published var selectedDuration: LearningDuration // starts with the current goal's duration
    @Published var showUpdateAlert = false // controls the "Update goal" alert
    private let original: LearningGoal // the goal as it was when the screen opened

    init(goal: LearningGoal) {
        self.original = goal
        self.subject = goal.subject
        self.selectedDuration = goal.duration
    }

    var trimmedSubject: String { subject.trimmingCharacters(in: .whitespaces) } // same trimming idea as canStart

    var canSave: Bool { !trimmedSubject.isEmpty } // checkmark is dimmed while the field is empty

    var hasChanges: Bool { // no change means no alert and no streak reset
        trimmedSubject != original.subject || selectedDuration != original.duration
    }
}