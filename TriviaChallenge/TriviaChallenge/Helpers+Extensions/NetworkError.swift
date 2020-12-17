//
//  NetworkError.swift
//  TriviaChallenge
//
//  Created by Jeremy Taylor on 12/16/20.
//

import Foundation

enum NetworkError: LocalizedError {
    case noTokenFound
    case tokenExpired
    case noData
    case unableToUnwrap
    case unableToDecode
    case apiError(Error) 
    
} //end of enum
