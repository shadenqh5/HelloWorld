//
//  OnboardingViewModel.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//
import Foundation
import Combine //ObservableObject and @Published come from Combine, so we import it here. (Models don’t need it.)

class OnboardingViewModel: ObservableObject {
    //a ViewModel is a class (not a struct) because the View and the ViewModel need to share one live object. If it were a struct, each would get its own copy.
    
    
    @Published var subject: String = ""  //the text in the “I want to learn” field. @Published means that whenever it changes, any view watching this ViewModel redraws itself. It starts as an empty string, which is why the field will show the “Swift” placeholder.
    
    @Published var selectedDuration: LearningDuration = .week  //the chosen chip. Its type is your enum, so it can only be week, month, or year. It starts as .week in the ui.

    var canStart: Bool {
        //a computed property, like freezeLimit. It answers “is the user allowed to tap Start Learning?” It trims spaces off the text and checks it isn’t empty, so typing only spaces doesn’t count.
        
        !subject.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func makeGoal() -> LearningGoal {
        //packages the two choices into a LearningGoal (the model from before). The startDate fills in automatically thanks to its default value.
        
        LearningGoal(subject: subject, duration: selectedDuration)
    }
}


//Why it’s a ViewModel: there’s no Text, no Color, no layout. It only holds screen state and decides things. Notice it also uses your Model but doesn’t redefine any of its rules. The freeze limit stays inside the enum.
