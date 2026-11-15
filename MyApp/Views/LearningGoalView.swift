//
//  LearningGoalView.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//


import SwiftUI

struct LearningGoalView: View {
    @StateObject private var viewModel: LearningGoalViewModel // this view owns the ViewModel
    @Environment(\.dismiss) private var dismiss // lets the view close itself and go back
    let onUpdate: (String, LearningDuration) -> Void // handed in by ActivityView, so this screen never touches its ViewModel

    init(goal: LearningGoal, onUpdate: @escaping (String, LearningDuration) -> Void) {
        _viewModel = StateObject(wrappedValue: LearningGoalViewModel(goal: goal))
        self.onUpdate = onUpdate
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 32) {
                // header: back button, centered title, checkmark
                ZStack {
                    Text("Learning Goal")
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

                        Button {
                            if viewModel.hasChanges {
                                viewModel.showUpdateAlert = true // changes reset the streak, so ask first
                            } else {
                                dismiss() // nothing changed, just go back
                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.orange, in: Circle())
                        }
                        .disabled(!viewModel.canSave)
                        .opacity(viewModel.canSave ? 1 : 0.4)
                    }
                }

                GoalForm(subject: $viewModel.subject, duration: $viewModel.selectedDuration)

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true) // we draw our own back button
        .alert("Update goal", isPresented: $viewModel.showUpdateAlert) {
            Button("Dismiss", role: .cancel) { } // stays on the screen, nothing changes
            Button("Update") {
                onUpdate(viewModel.trimmedSubject, viewModel.selectedDuration) // ActivityViewModel applies the update
                dismiss()
            }
        } message: {
            Text("If you update now, your streak will start over.")
        }
    }
}

#Preview {
    NavigationStack {
        LearningGoalView(goal: LearningGoal(subject: "Swift", duration: .week)) { _, _ in }
    }
}