//
//  ActivityViewModel..swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//

import Foundation
import Combine

class ActivityViewModel: ObservableObject {
    @Published var goal: LearningGoal // the goal made in onboarding
    @Published var learnedDates: Set<Date> = [] // each date is stored as start of day so comparing is easy
    @Published var frozenDates: Set<Date> = []
    @Published var goalStatus: GoalStatus = .active // from DayStatus
    private var lastActivity: Date // last time a day was logged or frozen, used for the 32 hour rule
    private let calendar = Calendar.current

    init(goal: LearningGoal) {
        self.goal = goal
        self.lastActivity = goal.startDate // the clock starts when the goal starts
    }

    // MARK: - What the screen shows

    var today: Date { calendar.startOfDay(for: Date()) }

    var dateText: String { // e.g. "Thursday, 24 October"
        Date().formatted(.dateTime.weekday(.wide).day().month(.wide))
    }

    var weekDays: [Date] { // the 7 days of the current week for the strip
        guard let start = calendar.dateInterval(of: .weekOfYear, for: Date())?.start else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    func letter(for date: Date) -> String { // S M T W T F S
        String(date.formatted(.dateTime.weekday(.narrow)))
    }

    func number(for date: Date) -> Int { calendar.component(.day, from: date) }

    func status(for date: Date) -> DayStatus { // learned wins if a day somehow has both
        if learnedDates.contains(date) { return .learned }
        if frozenDates.contains(date) { return .frozen }
        return .none
    }

    func isToday(_ date: Date) -> Bool { date == today }

    func countText(_ count: Int) -> String { // spec: "1" uses "Day", everything else "Days"
        count == 1 ? "\(count) Day" : "\(count) Days"
    }

    // MARK: - Button rules

    var isLoggedToday: Bool { learnedDates.contains(today) }
    var isFrozenToday: Bool { frozenDates.contains(today) }
    var freezesUsed: Int { frozenDates.count }
    var freezeLimit: Int { goal.duration.freezeLimit } // the rule lives in the enum, not here

    var canLog: Bool { !isLoggedToday }

    var canFreeze: Bool { // disabled if all freezes used or a day is logged
        !isLoggedToday && !isFrozenToday && freezesUsed < freezeLimit
    }

    // MARK: - Actions

    func logLearned() {
        guard canLog else { return }
        learnedDates.insert(today)
        lastActivity = Date()
        checkCompletion()
    }

    func freezeDay() {
        guard canFreeze else { return }
        frozenDates.insert(today)
        lastActivity = Date()
        checkCompletion()
    }

    func checkStreak() { // call when the screen appears: more than 32 hours without activity resets the streak
        guard goalStatus == .active else { return }
        let hours = Date().timeIntervalSince(lastActivity) / 3600
        if hours > 32 { goalStatus = .failed }
    }

    private func checkCompletion() { // assumption: learned + frozen days reaching the goal length completes it
        if learnedDates.count + frozenDates.count >= goal.duration.days {
            goalStatus = .completed
        }
    }
}
