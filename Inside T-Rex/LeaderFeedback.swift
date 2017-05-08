//
//  LeaderFeedback.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 5/1/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//  This class allows the user to send feedback to his/her manager. This
//  functionality is accessed from the profile portion of the application
//

import UIKit

class LeaderFeedback: UIViewController {

    /*
     *   Purpose: Called upon loading view controller
     *   Parameters: None
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }

    /*
     *   Purpose: Recieves memory waqrning
     *   Parameters: None
     *   Return: n/a
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var feedbackInput_txt: UITextField!
    @IBOutlet weak var sendFeedback_btn: UIBarButtonItem!
    @IBOutlet weak var cancelFeedback_btn: UIBarButtonItem!
    @IBOutlet weak var managerName_lbl: UILabel!
    
    /*
     *   Purpose: Allows user to send feedback
     *   Parameters: None
     *   Return: n/a
     */
    @IBAction func sendFeedback(_ sender: Any) {
        //var inputToSend = feedbackInput_txt.text
        SVProgressHUD.show()
        _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(displayMessage), userInfo: nil, repeats: false)

    }
    
    /*
     *   Purpose: Displays success message
     *   Parameters: None
     *   Return: n/a
     */
    func displayMessage(){
       SVProgressHUD.dismiss()
        let alert = UIAlertView()
        alert.title = "Feedback sent"
        alert.message = ("Your manager will be notified shortly")
        alert.addButton(withTitle: "Ok")
        alert.show()
    }
    
    @IBAction func cancelFeedbackPressed(_ sender: Any) {
    }
    
    /*
     *   Purpose: Dismisses keyboard from user's screen
     *   Parameters: None
     *   Return: n/a
     */
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
