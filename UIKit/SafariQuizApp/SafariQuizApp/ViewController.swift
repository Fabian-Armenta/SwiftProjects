//
//  ViewController.swift
//  SafariQuizApp
//
//  Created by Fabian Armenta on 16/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    
    var score = 0
    var currentQuestionIndex = 0
    
    let questions: [QuestionModel] = [
        QuestionModel(image: UIImage(named: "lion")!, correctAnswer: 2, answer1: "Hippo", answer2: "Lion", answer3: "Crocodile"),
        QuestionModel(image: UIImage(named: "giraffe")!, correctAnswer: 3, answer1: "Elephant", answer2: "Snake", answer3: "Giraffe"),
        QuestionModel(image: UIImage(named: "buffalo")!, correctAnswer: 1, answer1: "Buffalo", answer2: "Horse", answer3: "Antelope"),
    ]
    
    func setQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        questionImageView.image = currentQuestion.image
        answer1Button.setTitle(currentQuestion.answer1, for: .normal)
        answer2Button.setTitle(currentQuestion.answer2, for: .normal)
        answer3Button.setTitle(currentQuestion.answer3, for: .normal)
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        guard currentQuestionIndex <= questions.count - 1 else {
            currentQuestionIndex = 0
            score = 0
            scoreLabel.text = "Score: \(score)"
            setQuestion()
            return
        }
        setQuestion()
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.nextQuestion()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func check(selectAnswer answer: Int){
        let currentQuestion = questions[currentQuestionIndex]
        var alertTitle = ""
        var alertMessage = ""
        
        if currentQuestion.correctAnswer == answer {
            score += 1
            scoreLabel.text = "Score: \(score)"
            alertTitle = "Correct!"
            alertMessage = "You got it right!"
            
        } else{
            alertTitle = "Inorrect!"
            alertMessage = "You got it wrong!"
        }
        
        if currentQuestionIndex == questions.count - 1 {
            alertTitle = "End of Game!"
            alertMessage = "Your final Score is: \(score) of \(questions.count)"
            
        }
        showAlert(title: alertTitle, message: alertMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestion()
    }
    
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        check(selectAnswer: sender.tag)
    }
    
}

