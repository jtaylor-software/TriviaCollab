//
//  QuestionController.swift
//  TriviaChallenge
//
//  Created by Jeremy Taylor on 12/16/20.
//

import Foundation

class QuestionController {
    static let sharedInstance = QuestionController()
    
    /*
     Response Codes:
     Code 0: Success Returned results successfully.
     Code 1: No Results Could not return results. The API doesn't have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)
     Code 2: Invalid Parameter Contains an invalid parameter. Arguements passed in aren't valid. (Ex. Amount = Five)
     Code 3: Token Not Found Session Token does not exist.
     Code 4: Token Empty Session Token has returned all possible questions for the specified query. Resetting the Token is necessary.
     
     */
    
    //MARK - Properties
    
    private let baseURL = URL(string: "https://opentdb.com/api.php")
    private let tokenBaseURL = URL(string: "https://opentdb.com/api_token.php")
    private let tokenRequestQueryKey = "command"
    private let tokenRequestKey = "request"
    private let tokenQueryKey = "token"
    private let amountQueryKey = "amount"
    private let categoryQueryKey = "category"
    private let difficultyQueryKey = "difficulty"
    private let typeQueryKey = "type"
    
    var token: Token?
    
    //MARK - Methods
    func retrieveSessonToken(completion: @escaping (Result<Token, NetworkError>) -> Void) {
        guard let url = tokenBaseURL else { return completion(.failure(.unableToUnwrap)) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let tokenRequestQuery = URLQueryItem(name: tokenRequestQueryKey, value: tokenRequestKey)
        
        components?.queryItems = [tokenRequestQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.unableToUnwrap)) }
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.apiError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let token = try JSONDecoder().decode(Token.self, from: data)
                self.token = token
                completion(.success(token))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    } // End of retrieveSessionToken
    
    func retrieveQuestionsFor(category: QuestionCategory, ofType type: QuestionType, withDifficulty difficulty: QuestionDifficulty, andNumberOfQuestions amount: Int = 10, withToken: Token?, completion: @escaping (Result<[Question], NetworkError>) -> Void) {
        
        guard let url = baseURL else { return completion(.failure(.unableToUnwrap)) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let amountQuery = URLQueryItem(name: amountQueryKey, value: String(amount))
        
        let tokenQuery = URLQueryItem(name: tokenQueryKey, value: self.token?.token)
        
        let categoryQuery = URLQueryItem(name: categoryQueryKey, value: QuestionCategory.random.rawValue)
        
        let difficultyQuery = URLQueryItem(name: difficultyQueryKey, value: difficulty.rawValue)
        
        let typeQuery = URLQueryItem(name: typeQueryKey, value: type.rawValue)
        
        components?.queryItems = [amountQuery, tokenQuery, categoryQuery, difficultyQuery, typeQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.unableToUnwrap))}
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.apiError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                
                let results = try JSONDecoder().decode(TopLevelJSON.self, from: data)
                completion(.success(results.results))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
        
        
    } // end of retrieveQuestionsFor
    
    
} // end of class
