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
    var token: Token?
    var questionsArray: [Question] = []
    var question: Question?
    var correctAnswer: NSAttributedString?
    var correctAnswerTag: Int!
    var incorrectAnswers: [String] = []
    var score = 0
    var isGameOver = false
    
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
        if !isGameOver {
            checkCorrectAnswer(sender)
        } else {
            guard let token = token else { return }
            getQuestions(token: token)
            
        }
        
    }
    
    //MARK: - Methods
    
    func getSessionToken() {
        QuestionController.sharedInstance.retrieveSessonToken { (result) in
            switch result {
            
            case .success(let token):
                print("Token: \(token.token)")
                self.token = token
                self.getQuestions(token: token)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getQuestions(token: Token) {
        QuestionController.sharedInstance.retrieveQuestionsFor(category: .scienceAndComputers, ofType: .multiple, withDifficulty: .easy, andNumberOfQuestions: 10, withToken: token.token ) { (result) in
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
        isGameOver = false
    }
    
    func gameOver() {
        questionLabel.text = "Game Over!"
        
        hideOrShowButtons(true)
        answerButtonCollection[0].setTitle("New Game?", for: .normal)
        answerButtonCollection[0].isHidden = false
        isGameOver = true
    }
    
    func hideOrShowButtons(_ hide: Bool) {
        for button in answerButtonCollection {
            button.isHidden = hide
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
        guard !questionsArray.isEmpty else
        {
            gameOver()
            return
            
        }
        
        hideOrShowButtons(false)
        question = questionsArray.randomElement()
        questionLabel.attributedText = question?.question.htmlAttributedString(size: 25.0)
        correctAnswer = question?.correctAnswer.htmlAttributedString(size: 10.0)
        for answer in incorrectAnswers {
            answer.htmlAttributedString(size: 10.0)
            incorrectAnswers.append(answer)
        }
        setTitlesForButtons()
    }
    
}
