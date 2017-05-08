//
//  TakeLeadershipExam.swift
//  Inside T-Rex
//
//
//  Created by Esteban Keplinger on 5/1/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//  This class allows the user to take the leadership exam. This class
//  handles all functionality of the exam when the user is taking the exam.
//

import Foundation
import UIKit

class TakeLeadershipExam: UIViewController{
    
    var questions = [String]()
    var answers = [Character]()
    var questionOptions = [String]()
    var choices = [Character]()
    var currentQuestion: Int = 0//Set to 0 when exam starts
    var correctAns: Character = " "
    var numRightAns: Int = 0
    var testScore: Int = 0
    
    @IBOutlet weak var question_lbl: UILabel!
    
    @IBOutlet weak var choice1_lbl: UILabel!
    
    @IBOutlet weak var choice2_lbl: UILabel!
    
    @IBOutlet weak var choice3_lbl: UILabel!
    
    @IBOutlet weak var choice4_lbl: UILabel!
    
    @IBOutlet weak var choice1_btn: UIButton!
    @IBOutlet weak var choice2_btn: UIButton!
    @IBOutlet weak var choice3_btn: UIButton!
    @IBOutlet weak var choice4_btn: UIButton!
    
    @IBOutlet weak var doneExam_btn: UIButton!
    
    
    //@IBOutlet weak var nextQuestion_btn: UIButton!
    
    /*
     *   Purpose: Called when view controller is segued to
     *   Parameters: none
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        loadExamData()
        doExam(currentQuestion: 0)
        self.tabBarController?.tabBar.isHidden = false
        //tester()
    }
    
    /*
     *   Purpose: Loads exam data
     *   Parameters: none
     *   Return: n/a
     */
    func loadExamData(){
        currentQuestion = 0

        
        choices.append("A")
        choices.append("B")
        choices.append("C")
        choices.append("D")
        
        choice1_btn.setTitle(String(choices[0]), for: UIControlState.normal)
        choice2_btn.setTitle(String(choices[1]), for: UIControlState.normal)
        choice3_btn.setTitle(String(choices[2]), for: UIControlState.normal)
        choice4_btn.setTitle(String(choices[3]), for: UIControlState.normal)

    }
    
    /*
     *   Purpose: Allows user to take leadership exam
     *   Parameters: none
     *   Return: n/a
     */
    func doExam(currentQuestion: Int){
        
        switch(currentQuestion){
            
        case 0:
            correctAns = "C"
            
            question_lbl.text = "Question 1: In what order do managers typically perform the managerial functions?"

            
            choice1_lbl.text = "organising, planning, controlling, leading"
            choice2_lbl.text = "organising, leading, planning, controlling"
            choice3_lbl.text = "planning, organising, leading, controlling"
            choice4_lbl.text = "planning, organising, controlling, leading"
            break
            
        case 1:
            
            correctAns = "A"
                question_lbl.text = "Question 2: What are the three interpersonal roles of managers?"
            
            choice1_lbl.text = "Figurehead, leader and liaison"
            choice2_lbl.text = "Spokesperson, leader, coordinator"
            choice3_lbl.text = "Director, coordinator, disseminator"
            choice4_lbl.text = "Communicator, organiser, spokesperson"
            
            break
            
        case 2:
            
            correctAns = "D"
            question_lbl.text = "Question 3: Which one is not a recognised key skill of management?"
            
            choice1_lbl.text = "Conceptual skills"
            choice2_lbl.text = "Human skills"
            choice3_lbl.text = "Technical skills"
            choice4_lbl.text = "Writing skills"
            
            break
            
        case 3:
            
            correctAns = "A"
            question_lbl.text = "Question 4: Which of these is not part of the recognised challenges for modern managers?"
            
            choice1_lbl.text = "Micro-managing the workforce"
            choice2_lbl.text = "Managing communications"
            choice3_lbl.text = "Managing change"
            choice4_lbl.text = "Managing the learning organisation"
            
            break

        case 4:
            
            correctAns = "D"
            question_lbl.text = "Question 5: The advantage in small groups with a designated leader is:"
            
            choice1_lbl.text = "having someone in the group delineate power among members"
            choice2_lbl.text = "having someone in the group available to answer to the organization"
            choice3_lbl.text = "having someone in the group to coordinate the flow of communication and the work of members"
            choice4_lbl.text = "all of the above"
            
            break

        case 5:
            
            correctAns = "B"
            question_lbl.text = "Qeuestion 6: Appropriate leader behaviors in a group are shaped by the ___________ of the group"
            
            choice1_lbl.text = "traits"
            choice2_lbl.text = "needs"
            choice3_lbl.text = "behavior"
            choice4_lbl.text = "style"
            
            break
           
        case 5:
            
            correctAns = "B"
            question_lbl.text = "Question 7: Which of the following is not considered to be an effective communicative competency for discussion leaders?"
            
            choice1_lbl.text = "Effective group leaders inspire team members' confidence in themselves"
            choice2_lbl.text = "Effective group leaders express individual-centered concern"
            choice3_lbl.text = "Effective group leaders respect and support others"
            choice4_lbl.text = "Effective group leaders promote celebration of diversity and sensitive diversity management"
            
            break
            
        case 6:
            
            correctAns = "A"
            question_lbl.text = "Leadership is __________________"
            
            choice1_lbl.text = "The process of influencing a group toward the achievement of goals"
            choice2_lbl.text = "A group that achieves goals"
            choice3_lbl.text = "The function of influencing a group towards the achievement of goals"
            choice4_lbl.text = "Directing a group towards the achievement of goals"
            
            break
            
            
        default:
            choice1_btn.isHidden = true
            choice2_btn.isHidden = true
            choice3_btn.isHidden = true
            choice4_btn.isHidden = true
            
            choice1_lbl.isHidden = true
            choice2_lbl.isHidden = true
            choice3_lbl.isHidden = true
            choice4_lbl.isHidden = true
            
            choice1_btn.isEnabled = false
            choice2_btn.isEnabled = false
            choice3_btn.isEnabled = false
            choice4_btn.isEnabled = false
            
            choice1_lbl.isEnabled = false
            choice2_lbl.isEnabled = false
            choice3_lbl.isEnabled = false
            choice4_lbl.isEnabled = false
            
            //nextQuestion_btn.isHidden = true
            
            //testScore = numRightAns/questions.count
            
            print("Test score: ",testScore)
            question_lbl.text = "Your score: \(numRightAns) / 7"
            doneExam_btn.isHidden = false
            doneExam_btn.isEnabled = true
        }
        
    }//end do exam func

//    func scoreAnalysis(numRightAns: numRightAns){
//        return currentQuestion
//    }
    
//    @IBAction func nextQuestionPressed(_ sender: Any) {
//
//            //currentQuestion = currentQuestion+1
//            //doExam()
//    }
    
    /*
     *   Purpose: Next 4 methods are called when each respective button
     is clicked by the user. On hit, check to see if the button is the correct
     answer. If it is, increment number correct, and move to the next question
     *   Parameters: none
     *   Return: n/a
     */
    @IBAction func choice1Pressed(_ sender: Any) {
        
        if(correctAns == "A"){
            numRightAns += 1
        }
        currentQuestion = currentQuestion+1
        doExam(currentQuestion: currentQuestion)
    }
    
    @IBAction func choice2Pressed(_ sender: Any) {
        choice2_btn.reversesTitleShadowWhenHighlighted = true

        if(correctAns == "B"){
            numRightAns += 1
        }
        currentQuestion = currentQuestion+1
        doExam(currentQuestion: currentQuestion)
    }
    
    @IBAction func choice3Pressed(_ sender: Any) {

        if(correctAns == "C"){
            numRightAns += 1
        }
        currentQuestion = currentQuestion+1
        doExam(currentQuestion: currentQuestion)
    }
    
    @IBAction func choice4Pressed(_ sender: Any) {

        if(correctAns == "D"){
            numRightAns += 1
        }
        currentQuestion = currentQuestion+1
        doExam(currentQuestion: currentQuestion)
    }
    
    /*
     *   Purpose: Records score, takes user back to the home screen
     *   Parameters: none
     *   Return: n/a
     */
    @IBAction func doneExamPressed(_ sender: Any) {
        performSegue(withIdentifier: "backToLeader_seg", sender: doneExam_btn)
    }
    
    
    
}//end class
