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
                        .foregroundStyle(Color.appOrange) //colors it with the orange from the asset catalog
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
                    
                    GoalForm(subject: $viewModel.subject, duration: $viewModel.selectedDuration) // the field and chips now live in GoalForm, shared with the Learning Goal screen
                    
                    Spacer() //takes all the remaining height, which forces the VStack to fill the screen and squeezes the flame up to the top.
                    
                    VStack(spacing: 8) {
                        Button {
                            // builds the goal from the user's input; navigation to the Activity screen
                            startedGoal = viewModel.makeGoal()
                        } label: {
                            Text("Start Learning")
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                        }
                        .buttonStyle(.glassProminent) // real Liquid Glass button, disabled state dims automatically
                        .tint(Color.appOrange)
                        .disabled(!viewModel.canStart) // canStart lives in the ViewModel, the View only asks it

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
