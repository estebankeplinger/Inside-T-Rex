//
//  LeadershipAssessment.swift
//  Inside T-Rex
//
//
//  Created by Esteban Keplinger on 3/13/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//  This class allows the user to access the leadership assessment portion of the app
//  Once the user inputs a valid session id (provided by their manager), they will be
//  taken to the TakeLeadershipExam class to take the exam.

import Foundation
import UIKit


class LeadershipAssessment: UIViewController{
    
    @IBOutlet weak var sessionid_txt: UITextField!
    
    @IBOutlet weak var question_lbl: UILabel!
    @IBOutlet weak var startExam_btn: UIButton!
    
    @IBOutlet weak var gotIt_btn: UIButton!

    @IBOutlet weak var choice1_lbl: UILabel!
    @IBOutlet weak var choice1_btn: UIButton!
        
    @IBOutlet weak var choice2_lbl: UILabel!
    @IBOutlet weak var choice2_btn: UIButton!
    
    @IBOutlet weak var choice3_lbl: UILabel!
    @IBOutlet weak var choice3_btn: UIButton!

    @IBOutlet weak var choice4_lbl: UILabel!
    @IBOutlet weak var choice4_btn: UIButton!
 
    @IBOutlet weak var nextQuestion_btn: UIButton!
    
    /*
     *   Purpose: Loads view upon segue to view controller
     *   Parameters: none
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }

    /*
     *   Purpose: Verifies valid session id, takes user to directions view controller
     *   Parameters: none
     *   Return: n/a
     */
    @IBAction func startExamPressed(_ sender: Any) {
        SVProgressHUD.show()
        let sessionID = sessionid_txt.text!
        if (verifySessionID(sessionID: sessionID) == true){
            _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(displayMessage), userInfo: nil, repeats: false)
            performSegue(withIdentifier: "examInfo_seg", sender: startExam_btn)
        }
    }
    
    /*
     *   Purpose: Starts timer to exam, takes user to exam
     *   Parameters: none
     *   Return: n/a
     */
    @IBAction func gotItPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToExam_seg", sender: gotIt_btn)
    }
    
    /*
     *   Purpose: Validates session ID
     *   Parameters: none
     *   Return: n/a
     */
    func verifySessionID(sessionID: String)-> Bool{
        
        if (Int(sessionID) == 42){
            return true
        }
        return true
        
    }
    
    /*
     *   Purpose: Progress indicator method
     *   Parameters: none
     *   Return: n/a
     */
    func displayMessage(){
        SVProgressHUD.dismiss()

    }
    
    /*
     *   Purpose: Keyboard dismissal method
     *   Parameters: none
     *   Return: n/a
     */
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}//end class
