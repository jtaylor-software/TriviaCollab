//
//  Question.swift
//  TriviaChallenge
//
//  Created by Jeremy Taylor on 12/16/20.
//

import Foundation

struct Question: Codable {
    let questionText: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case questionText
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
        
    }
} //end of struct

struct TopLevelJSON: Codable {
    let results: [Question]
} //end of struct
