//
//  CalendarView.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//


import SwiftUI

struct CalendarView: View {
    private let viewModel: CalendarViewModel // no @StateObject needed, nothing in it changes
    @Environment(\.dismiss) private var dismiss // closes the screen and goes back

    init(goal: LearningGoal, learnedDates: Set<Date>, frozenDates: Set<Date>) {
        viewModel = CalendarViewModel(goal: goal, learnedDates: learnedDates, frozenDates: frozenDates)
    }

    private let columns = Array(repeating: GridItem(.flexible()), count: 7) // 7 equal columns, one per weekday

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // header: back button and centered title
                ZStack {
                    Text("Activities")
                        .font(.headline)
                        .foregroundStyle(.white)

                    HStack {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.1), in: Circle())
                        }
                        Spacer()
                    }
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 24) { // one section per month
                        ForEach(viewModel.months, id: \.self) { month in
                            monthSection(month)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true) // we draw our own back button
    }

    // MARK: - Pieces of the screen

    private func monthSection(_ month: Date) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.title(for: month))
                .font(.headline)
                .foregroundStyle(.white)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.weekdayHeaders, id: \.self) { header in // weekday names row
                    Text(header)
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.gray)
                }

                ForEach(Array(viewModel.cells(for: month).enumerated()), id: \.offset) { _, date in
                    if let date {
                        dayCell(date)
                    } else {
                        Color.clear.frame(height: 40) // empty spot before the 1st
                    }
                }
            }

            Divider()
                .overlay(Color.gray.opacity(0.4))
        }
    }

    private func dayCell(_ date: Date) -> some View {
        let status = viewModel.status(for: date)
        let isToday = viewModel.isToday(date)

        // same colors as DayCircle: learned is dim orange, frozen is dim blue, today is solid orange
        let textColor: Color = status == .learned ? .orange : status == .frozen ? .cyan : .white
        let circleColor: Color = status == .learned ? Color.orange.opacity(0.2)
            : status == .frozen ? Color.cyan.opacity(0.2)
            : (isToday ? .orange : .clear)

        return Text("\(viewModel.number(for: date))")
            .font(.body)
            .foregroundStyle(textColor)
            .frame(width: 40, height: 40)
            .background(circleColor, in: Circle())
    }
}

#Preview {
    NavigationStack {
        CalendarView(goal: LearningGoal(subject: "Swift", duration: .month), learnedDates: [], frozenDates: [])
    }
}