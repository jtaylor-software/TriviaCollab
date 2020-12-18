//
//  QuestionsViewController.swift
//  TriviaChallenge
//
//  Created by Michael Nguyen on 12/16/20.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var currentRoundLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet var answerButtonCollection: [UIButton]!
    
    //MARK: - Properties
    
    var seclectedCategory: QuestionCategory?
    var selectedDifficulty: QuestionDifficulty?
    var questionsArray: [Question] = []
    var question: Question?
    var correctAnswer: NSAttributedString?
    var correctAnswerTag: Int!
    var incorrectAnswers: [String] = []
    var score = 0
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getSessionToken()
    }
    
    //MARK: - Actions
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            print("Answer 1")
        } else if sender.tag == 2 {
            print ("Answer 2")
        } else if sender.tag == 3 {
            print ("Answer 3")
        } else if sender.tag == 4{
            print ("Answer 4")
        }
        checkCorrectAnswer(sender)
        
    }
    
    //MARK: - Methods
    
    func getSessionToken() {
        QuestionController.sharedInstance.retrieveSessonToken { (result) in
            switch result {
            
            case .success(let token):
                print("Token: \(token.token)")
                self.getQuestions(token: token)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getQuestions(token: Token) {
        QuestionController.sharedInstance.retrieveQuestionsFor(category: .random, ofType: .multiple, withDifficulty: .medium, withToken: token.token ) { (result) in
            switch result {
            
            case .success(let questions):
                DispatchQueue.main.async {
                    self.questionsArray = questions
                    self.reloadViews()
                }
                
            case .failure(_):
                print ("Error")
            }
        }
    }
    
    func setTitlesForButtons() {
        correctAnswerTag = answerRandomizer()
        var count = 0
        for button in answerButtonCollection {
            if button.tag == correctAnswerTag {
                button.setTitle(question?.correctAnswer, for: .normal)
            } else if button.tag != correctAnswerTag {
                button.setTitle(question?.incorrectAnswers[count], for: .normal)
                count += 1
            }
        }
    }
    
    func checkCorrectAnswer(_ sender: UIButton) {
        if sender.tag == correctAnswerTag {
            updateScore()
        }
        reloadQuestion()
    }
    
    func updateScore() {
        score += 100
        currentScoreLabel.text = "Score: \(score)"
    }
    
    func reloadQuestion() {
        guard questionsArray.count > 0 else { return }
        question = questionsArray.randomElement()
        guard let index = questionsArray.firstIndex(of: question!) else { return }
        questionsArray.remove(at: index)
        reloadViews()
    }
    
    func answerRandomizer() -> Int {
        return Int.random(in: 1...4)
    }
    func reloadViews() {
        guard questionsArray.count > 0 else { return }
        
        question = questionsArray.randomElement()
        questionLabel.attributedText = question?.question.htmlAttributedString(size: 25.0)
        correctAnswer = question?.correctAnswer.htmlAttributedString(size: 10.0)
        incorrectAnswers.append(contentsOf: question!.incorrectAnswers)
        setTitlesForButtons()
    }
    
}
