//
//  LearningDuration.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//
import Foundation //gives you the non-visual stuff: dates, storage, data handling.

enum LearningDuration: String, CaseIterable {
    
    //an enum is a type with a fixed list of options. The user can only pick Week, Month, or Year, so the enum makes any other value impossible.
    //":String" this says each case has a text value attached.
    //"CaseIterable" this makes Swift build a list of all the cases for you, called allCases. Your view can then loop over it to create the three chips, so you don’t write them by hand.
    
    case week = "Week"
    case month = "Month"
    case year = "Year"

    var freezeLimit: Int { //this is a computed property(does not store a value). It works out the answer each time u asl. Int means the answer is a whole number
        
        switch self {  //self means “whichever case this is right now.” The switch checks it and runs the matching line.
            
        case .week: return 2
        case .month: return 8
        case .year: return 96
            //: if the duration is week, the answer is 2. The month and year lines work the same way (8 and 96, straight from your spec sheet). 
        }
        
    }
    var days: Int { // goal length in days, used to decide when the goal is completed
        switch self {
        case .week: return 7
        case .month: return 30
        case .year: return 365
        }
    }
}
