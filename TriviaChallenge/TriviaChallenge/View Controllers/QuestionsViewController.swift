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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func firstAnswerButtonTapped(_ sender: Any) {
    }
    @IBAction func secondAnswerButtonTapped(_ sender: Any) {
    }
    @IBAction func thirdAnswerButtonTapped(_ sender: Any) {
    }
    @IBAction func fourthAnswerButtonTapped(_ sender: Any) {
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
