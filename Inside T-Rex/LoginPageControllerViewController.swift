//
//  LoginPageControllerViewController.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/9/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//

import UIKit

class LoginPageControllerViewController: UIViewController {
    
    @IBOutlet weak var userName_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var register_btn: UIButton!
    @IBOutlet weak var loginGo_btn: UIButton!
    @IBOutlet weak var loginFeedback_lbl: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var help_btn: UINavigationItem!
    
    /*
     *   Purpose: Called function upon user opening login page
     *   Parameters: none
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add gesture recognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)


        // Do any additional setup after loading the view.
    }
    
    /*
     *   Purpose: Dismisses keyboard on user tap outside of text field
     *   Parameters: none
     *   Return: n/a
     */
    func dismissKeyboard() {
        view.endEditing(true)
    }

    /*
     *   Purpose: Triggers segue to take user to help screen
     *   Parameters: help button
     *   Return: n/a
     */
    @IBAction func helpBtnPressed(_ sender: Any) {
                performSegue(withIdentifier: "helpPressed_seg", sender: register_btn)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     *   Purpose: Moves cursor to password text field on enter key hit
     *   Parameters: Text field
     *   Return: boolean
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == userName_txt { // Switch focus to other text field
            password_txt.becomeFirstResponder()
        }
        return true
    }
    
    
    /*
     *   Purpose: Takes user to create account
     *   Parameters: Register button
     *   Return: n/a
     */
    @IBAction func registerbtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "registerPressed_seg", sender: register_btn)
    }
    
    
    /*
     *   Purpose: Triggered when user presses 'Go' button
            Authenticates user, logs them in
     *   Parameters: Button pressed
     *   Return: n/a
     */
    @IBAction func isGoPressed(_ sender: Any) {
        let usernameInput: String = userName_txt.text!
        let passwordInput: String = password_txt.text!
        
        //if user inputs corrext password, log them in
        if (checkUsername(usernameInput: usernameInput) == true){
            if (checkPassword(passwordInput: passwordInput) == true){
                
                
                loginFeedback_lbl.textColor = UIColor.green
                loginFeedback_lbl.text = "Success"

                performSegue(withIdentifier: "goPressed_seg", sender: loginGo_btn)
                
            }
        }
        else{
            loginFeedback_lbl.textColor = UIColor.red
            loginFeedback_lbl.text = "Fail"
            return
            
        }
    }
    
    /*
     *   Purpose: Checks username field input against database record
     *   Parameters: username string
     *   Return: true if username matches database records,
            false otherwise
     */
    func checkUsername(usernameInput: String)-> Bool{

        return true;
    }
    
    /*
     *   Purpose: Checks password field input against database record
     *   Parameters: password string
     *   Return: true if password matches database records,
     false otherwise
     */
    func checkPassword(passwordInput: String)-> Bool{
        return true;
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
