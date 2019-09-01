//
//  ViewController.swift
//  Quiz App IOS
//
//  Created by Ahmed El-Mahdi on 8/26/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate ,QuizProtocol, ResultViewControllerProtocol{
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var answerTableView: UITableView!
    
    var questions = [Questions]()
    
    var model = QuizModel()
    
    var questionIndex = 0
    
    var numCorrect = 0
    var ResultVC :ResultViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultVC = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
        ResultVC?.delegate = self
        
        ResultVC?.modalPresentationStyle = .overCurrentContext
        
        
        // Configure the tableview for dynamic row height
        answerTableView.estimatedRowHeight = 100
        answerTableView.rowHeight = UITableView.automaticDimension
        
        answerTableView.delegate = self
        answerTableView.dataSource = self
        
        
        model.delegate = self
        model.getQuestions()
        
        // Do any additional setup after loading the view.
    }
    
    func questionRetieved(questions: [Questions]) {
        self.questions = questions
        displayQuestion()
    }
    
    func displayQuestion(){
        guard questionIndex < questions.count else {
            print("Out Of Index")
            return
        }
        questionLabel.text = questions[questionIndex].question
        answerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard questions.count > 0 && questions[questionIndex].answers != nil else {
            return 0
        }
        
        return questions[questionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellItem", for: indexPath)
        
        let label = cell.viewWithTag(1) as! UILabel
        
        label.text = questions[questionIndex].answers[indexPath.row]
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard questionIndex < questions.count else {
            return
        }
        var title:String = ""
        let message:String = questions[questionIndex].feedback!
        let action:String = "Next"
        
        
        if questions[questionIndex].correctAnswerIndex! == indexPath.row {
            
            numCorrect += 1
            title = "Correct"
            
        }else {
            title = "Wrong!"
        }
        
        if ResultVC != nil {
            
            DispatchQueue.main.async {
                self.present(self.ResultVC!, animated: true, completion: {
                    // Set the message for the popup:
                    self.ResultVC!.displayPopup(withTitle: title, withMassage: message, withAction: action)
                })
            }
        }
        self.questionIndex += 1
        
    }
    func resultViewedismissed() {
        
        if questionIndex == questions.count{
            if ResultVC != nil {
                present(ResultVC!, animated: true) {
                    self.ResultVC!.displayPopup(withTitle: "Summary", withMassage: "You Got \(self.numCorrect) out of \(self.questions.count) correct", withAction: "Restart")
                    
                }
            }
            self.questionIndex += 1
            
        }
        else if questionIndex > questions.count{
            questionIndex = 0
            numCorrect = 0
            displayQuestion()
        }
        else{
            displayQuestion()
            
        }
        
    }
}

