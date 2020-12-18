//
//  NetworkError.swift
//  TriviaChallenge
//
//  Created by Michael Nguyen on 12/17/20.
//

import Foundation

enum NetworkError: LocalizedError {
    case noTokenFound
    case tokenExpired
    case noData
    case unableToUnwrap
    case unableToDecode
    case apiError(Error)
}
