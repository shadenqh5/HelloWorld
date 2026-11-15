//
//  ActivityView.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//


import SwiftUI

struct ActivityView: View {
    @StateObject private var viewModel: ActivityViewModel // this view owns the ViewModel
    @State private var showGoalScreen = false // true while the Learning Goal screen is open
    @State private var showCalendar = false // true while the Calendar screen is open

    init(goal: LearningGoal) { // the goal comes from onboarding, so the ViewModel is built here
        _viewModel = StateObject(wrappedValue: ActivityViewModel(goal: goal))
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                // header: title and the two round buttons
                HStack {
                    Text("Activity")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)

                    Spacer()

                    Button { showCalendar = true } label: { // opens the Calendar screen
                        Image(systemName: "calendar")
                            .foregroundStyle(.white)
                            .frame(width: 28, height: 28)
                    }
                    .buttonStyle(.glass) // real Liquid Glass round button
                    .buttonBorderShape(.circle)

                    Button { showGoalScreen = true } label: { // opens the Learning Goal screen
                        Image(systemName: "pencil.and.outline") // check the exact symbol in the SF Symbols app
                            .foregroundStyle(.white)
                            .frame(width: 28, height: 28)
                    }
                    .buttonStyle(.glass)
                    .buttonBorderShape(.circle)
                }

                Text(viewModel.dateText)
                    .foregroundStyle(.gray)

                // week strip: one circle per day, colored by its status
                HStack {
                    ForEach(viewModel.weekDays, id: \.self) { date in
                        DayCircle(
                            letter: viewModel.letter(for: date),
                            number: viewModel.number(for: date),
                            status: viewModel.status(for: date),
                            isToday: viewModel.isToday(date)
                        )
                        .frame(maxWidth: .infinity)
                    }
                }

                // stat cards
                HStack(spacing: 12) {
                    StatCard(symbol: "flame.fill", tint: .appOrange,
                             value: viewModel.countText(viewModel.learnedDates.count), label: "Learned")
                    StatCard(symbol: "snowflake", tint: .appBlue,
                             value: viewModel.countText(viewModel.frozenDates.count), label: "Freezed")
                }

                Spacer()

                // the bottom area changes with the goal status
                switch viewModel.goalStatus {
                case .active:
                    activeContent
                case .completed:
                    finishedContent(symbol: "hands.clap.fill",
                                    title: "Well done!",
                                    subtitle: "Ready for your next goal?")
                case .failed:
                    finishedContent(symbol: "xmark.seal.fill",
                                    title: "You didn't reach your goal this time.",
                                    subtitle: "Want to set another goal?")
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true) // no going back to onboarding
        .onAppear { viewModel.checkStreak() } // applies the 32 hour rule
        .navigationDestination(isPresented: $showGoalScreen) { // pushes the Learning Goal screen
            LearningGoalView(goal: viewModel.goal) { subject, duration in
                viewModel.updateGoal(subject: subject, duration: duration) // runs when the user taps Update in the alert
            }
        }
        .navigationDestination(isPresented: $showCalendar) { // pushes the Calendar screen
            CalendarView(goal: viewModel.goal,
                         learnedDates: viewModel.learnedDates,
                         frozenDates: viewModel.frozenDates) // view only, so it just receives the data
        }
    }

    // MARK: - Pieces of the screen

    private var activeContent: some View {
        VStack(spacing: 20) {
            Button { viewModel.logLearned() } label: {
                Text(viewModel.isLoggedToday ? "Logged as Learned" : "Log as Learned")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(viewModel.isLoggedToday ? Color.gray : Color.white)
                    .frame(width: 260, height: 260)
            }
            .buttonStyle(.glassProminent) // real Liquid Glass, goes dim by itself once disabled
            .buttonBorderShape(.circle)
            .tint(Color.appOrange)
            .disabled(!viewModel.canLog)
            .padding(.bottom, 40)
            VStack(spacing: 8) {
                Button { viewModel.freezeDay() } label: {
                    Text(viewModel.isFrozenToday ? "Freezed for a day" : "Freeze for a day")
                        .foregroundStyle(viewModel.canFreeze ? Color.white : Color.gray)
                        .padding(.horizontal, 60)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.glassProminent) // blue glass while available, dim glass when disabled
                .tint(Color.appBlue)
                .disabled(!viewModel.canFreeze) // all freezes used, a day logged, or already frozen today

                Text("\(viewModel.freezesUsed) out of \(viewModel.freezeLimit) Freezes used")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        
    }

    private func finishedContent(symbol: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 12) { // shared by the completed and failed states, only the texts differ
            Image(systemName: symbol)
                .font(.system(size: 44))
                .foregroundStyle(Color.appOrange)

            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.gray)

            Button { showGoalScreen = true } label: { // opens the Learning Goal screen
                Text("Set a goal")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 2)
            }
            .buttonStyle(.glassProminent)
            .tint(Color.appOrange)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        ActivityView(goal: LearningGoal(subject: "Swift", duration: .week))
    }
}
