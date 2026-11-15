//
//  CalendarViewModel.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//


import Foundation

struct CalendarViewModel { // a struct is enough here: the calendar only shows a snapshot and never changes anything
    let goal: LearningGoal
    let learnedDates: Set<Date> // passed in from the Activity screen
    let frozenDates: Set<Date>
    private let calendar = Calendar.current

    var months: [Date] { // first day of every month from the goal's start to the goal's last day
        let start = calendar.startOfDay(for: goal.startDate)
        guard let firstMonth = calendar.dateInterval(of: .month, for: start)?.start,
              let end = calendar.date(byAdding: .day, value: goal.duration.days - 1, to: start) else { return [] }
        var result: [Date] = []
        var current = firstMonth
        while current <= end {
            result.append(current)
            guard let next = calendar.date(byAdding: .month, value: 1, to: current) else { break }
            current = next
        }
        return result
    }

    func title(for month: Date) -> String { // e.g. "January 2026"
        month.formatted(.dateTime.month(.wide).year())
    }

    var weekdayHeaders: [String] { // SUN MON TUE ..., starting from the calendar's first weekday
        let symbols = calendar.shortWeekdaySymbols.map { $0.uppercased() }
        let shift = calendar.firstWeekday - 1
        return Array(symbols[shift...] + symbols[..<shift])
    }

    func cells(for month: Date) -> [Date?] { // nil entries are the empty spots before the 1st
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return [] }
        let weekday = calendar.component(.weekday, from: month)
        let blanks = (weekday - calendar.firstWeekday + 7) % 7
        var result: [Date?] = Array(repeating: nil, count: blanks)
        for day in range {
            result.append(calendar.date(byAdding: .day, value: day - 1, to: month))
        }
        return result
    }

    func number(for date: Date) -> Int { calendar.component(.day, from: date) }

    func status(for date: Date) -> DayStatus { // same rule as the Activity screen
        if learnedDates.contains(date) { return .learned }
        if frozenDates.contains(date) { return .frozen }
        return .none
    }

    func isToday(_ date: Date) -> Bool { calendar.isDateInToday(date) }
}