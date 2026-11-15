//
//  GoalForm.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//


import SwiftUI

struct GoalForm: View { // the text field and chips, shared by any screen that edits a goal
    @Binding var subject: String // bindings so this view edits the owner's data instead of keeping its own copy
    @Binding var duration: LearningDuration

    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text("I want to learn")
                    .foregroundStyle(.white)

                TextField("", text: $subject, prompt: Text("Swift").foregroundStyle(.gray)) //the field shows and edits subject in the owner's ViewModel. The first "" is the label which shows empty. the $ creates a binding, a two-way connection. When the user types, subject in the ViewModel updates. If the ViewModel changes subject, the field updates too. Without the $, the field could only display the value, not change it. the placeholder shown while the field is empty. Using prompt instead of a plain label lets me style it.
                    .foregroundStyle(.white) // this is the color of what the user types, separate from the placeholder.

                Divider() //the thin line under the field. The default divider is quite visible on black, so the overlay softens it to a dim grey.
                    .overlay(Color.gray.opacity(0.4))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 12) {
                Text("I want to learn it in a")
                    .foregroundStyle(.white)

                HStack {
                    // allCases comes from CaseIterable, so one chip is built per duration
                    ForEach(LearningDuration.allCases, id: \.self) { option in
                        DurationChip(
                            title: option.rawValue, // "Week", "Month" or "Year"
                            isSelected: duration == option // highlights the chosen chip
                        ) {
                            duration = option // tap action: store the choice through the binding
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
