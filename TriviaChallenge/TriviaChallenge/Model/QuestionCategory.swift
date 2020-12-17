//
//  QuestionCategory.swift
//  TriviaChallenge
//
//  Created by Jeremy Taylor on 12/16/20.
//

import Foundation

enum QuestionCategory {
    case scienceAndComputers
    case entertainmentMusic
    case mythology
    case cartoonAnimations
    case random
    
    var randomInt: Int {
        return [18, 12, 20, 32].randomElement()!
    }
    
    var rawValue: String {
        switch self {
        
        case .scienceAndComputers:
            return "18"
        case .entertainmentMusic:
            return "12"
        case .mythology:
            return "20"
        case .cartoonAnimations:
            return "32"
        case .random:
            return "\(randomInt)"
        }
    }
    
} // End of enum
