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
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    
    //MARK: - Properties
    var questionsArray: [Question] = []
    var question: Question?
    var correctAnswer: String?
    var incorrectAnswers: [String] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionController.sharedInstance.retrieveSessonToken { (_) in
            
        }
        QuestionController.sharedInstance.retrieveQuestionsFor(category: .random, ofType: .multiple, withDifficulty: .medium, withToken: nil) { (result) in
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
        // Do any additional setup after loading the view.
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
        reloadQuestion()
    }
    func setTitlesForButtons() {
        
    }
    func reloadQuestion() {
        guard questionsArray.count > 0 else { return }
        questionsArray.remove(at: 0)
        question = questionsArray.randomElement()
        reloadViews()
    }
    
    func answerRandomizer() -> Int {
        return Int.random(in: 1...4)
    }
    func reloadViews() {
        guard questionsArray.count > 0 else { return }
//        guard let answer = correctAnswer else { return }
        question = questionsArray.randomElement()
        questionLabel.text = question!.question
        correctAnswer = question!.correctAnswer
        incorrectAnswers.append(contentsOf: question!.incorrectAnswers)
        setTitlesForButtons()
    }

    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
