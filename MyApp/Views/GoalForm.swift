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

                TextField("", text: $subject, prompt: Text("Swift").foregroundStyle(.gray))
                    .foregroundStyle(.white)

                Divider()
                    .overlay(Color.gray.opacity(0.4))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 12) {
                Text("I want to learn it in a")
                    .foregroundStyle(.white)

                HStack {
                    ForEach(LearningDuration.allCases, id: \.self) { option in
                        DurationChip(
                            title: option.rawValue,
                            isSelected: duration == option
                        ) {
                            duration = option
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}