//
//  OnboardingView.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//
import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel() //this creates the ViewModel once and keeps it alive for as long as this view exists. @StateObject means “this view owns it.” Whenever a @Published property changes, the view redraws.
    @State private var startedGoal: LearningGoal? // when this gets a value, the app moves to the Activity screen
    var body: some View {
        NavigationStack{
            ZStack { //to make the background black without interfering with other content
                Color.black
                    .ignoresSafeArea()

                VStack(spacing: 32) {
                    // ontent goes here, piece by piece
                    Image(systemName: "flame.fill") //loads an SF Symbol by name. flame.fill is the filled version.
                        .font(.system(size: 40)) //sizes the symbol the same way you'd size text, since SF Symbols behave like text characters.
                        .foregroundStyle(Color.orange) //colors it. This is still the system orange
                        .padding(.top, 60) // pushes the flame down from the top
                        .padding(.bottom, 40) // extra gap before the greeting, on top of the spacing
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hello **Learner**")
                            .font(.largeTitle)
                            .foregroundStyle(.white)

                        Text("This app will help you learn everyday!")
                            .font(.subheadline) //built-in text sizes.
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) //makes that block stretch across the full width and stick to the left edge.
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("I want to learn")
                            .foregroundStyle(.white)

                        TextField("", text: $viewModel.subject, prompt: Text("Swift").foregroundStyle(.gray)) //the field shows and edits subject in my ViewModel. The first "" is the label which shows empty. the $ creates a binding, a two-way connection. When the user types, subject in the ViewModel updates. If the ViewModel changes subject, the field updates too. Without the $, the field could only display the value, not change it. the placeholder shown while the field is empty. Using prompt instead of a plain label lets me style it.
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
                            ForEach(LearningDuration.allCases, id: \.self) { duration in
                                DurationChip(
                                    title: duration.rawValue, // "Week", "Month" or "Year"
                                    isSelected: viewModel.selectedDuration == duration // highlights the chosen chip
                                ) {
                                    viewModel.selectedDuration = duration // tap action: store the choice in the ViewModel
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer() //takes all the remaining height, which forces the VStack to fill the screen and squeezes the flame up to the top.
                    
                    VStack(spacing: 8) {
                        Button {
                            // builds the goal from the user's input; navigation to the Activity screen
                            startedGoal = viewModel.makeGoal()
                        } label: {
                            Text("Start Learning")
                                .foregroundStyle(.white)
                                .padding(.horizontal, 28)
                                .padding(.vertical, 12)
                                .background(Color.orange, in: Capsule())
                        }
                        .disabled(!viewModel.canStart) // canStart lives in the ViewModel, the View only asks it
                        .opacity(viewModel.canStart ? 1 : 0.4) // dimmed look while the field is empty

                        Text("You can edit your desire later")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.bottom, 16) // small gap above the home indicator
                }
                .padding(.horizontal, 24) //keeps content off the screen edges
            }
            .navigationDestination(item: $startedGoal) { goal in // when startedGoal gets a value, show ActivityView with that goal
                        ActivityView(goal: goal)
        }
        
                }
        
    }
}

#Preview {
    OnboardingView()
}
