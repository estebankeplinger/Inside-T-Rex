//
//  Register.swift
//  Inside T-Rex
//
//
//  Created by Esteban Keplinger on 4/16/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//  This class allows the user to register for an account by verifying the user
//  has a first and last name in the database (this means that only employees whose
//  data is already in the database can log in).
//

import UIKit

class Register: UIViewController {
    
    
    @IBOutlet weak var logoImage_img: UIImageView!
    @IBOutlet weak var createAccount_lbl: UILabel!
    @IBOutlet weak var fname_txt: UITextField!
    @IBOutlet weak var lname_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var checkPassword_txt: UITextField!
    @IBOutlet weak var createAcc_btn: UIButton!
    @IBOutlet var registerFeedback_lbl: UIView!
    @IBOutlet weak var backFromReg_btn: UIBarButtonItem!
    
    /*
     *   Purpose: Called when register button is tapped
     *   Parameters: none
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add tap gesture recognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
        
    }
    
    /*
     *   Purpose: Function to dismiss keyboard on user tap
     *   Parameters: none
     *   Return: n/a
     */
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
     *   Purpose: Segue to take user back from register page to login page
     *   Parameters: Cancel button pressed
     *   Return: n/a
     */
    @IBAction func backToLogin(_ sender: Any) {
        performSegue(withIdentifier: "backFromRegister_seg", sender: backFromReg_btn)
    }
    
    /*
     *   Purpose: Segue to take user back to login page
     Checks if first name and last name are in database.
     If they are, save inputted information, create account
     *   Parameters: Create account button
     *   Return: IBAction
     */
    @IBAction func createAccount(_ sender: Any) {
        SVProgressHUD.show()
        
        //        if (checkUserInput() == true){
        //
        //
        //            //        let parameters: Parameters=[
        //            //            "fname":fname_txt.text!,
        //            //            "lname":lname_txt.text!,
        //            //            "password":textFieldName.text!
        //            //        ]
        //
        //            performSegue(withIdentifier: "finishAccRegister_seg", sender: createAcc_btn)
        //        }
        
        if (checkUserInput() != false){
            if(callRegisterFunction(fname: fname_txt.text!, lname: lname_txt.text!, pass: password_txt.text!, checkP: checkPassword_txt.text!) == true){
                
                _ = Timer.scheduledTimer(timeInterval: 2.3, target: self, selector: #selector(loadHomeScreen), userInfo: nil, repeats: false)
            }
                else{
                    _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showFailDialog), userInfo: nil, repeats: false)
                }
            
        }
        
        
        
        
        
    }//end create acc
    
    /*
     *   Purpose: Loads home screen upon valid account creation
     *   Parameters: none
     *   Return: n/a
     */
    func loadHomeScreen(){
        SVProgressHUD.dismiss()
        
        let alert = UIAlertView()
        alert.title = "Account Creation Successful"
        alert.message = ("Username is your Firstname-Lastname")
        alert.addButton(withTitle: "Got it")
        alert.show()
        performSegue(withIdentifier:"finishAccRegister_seg", sender: self)
        
    }
    
    /*
     *   Purpose: Fail dialog if user registration fails
     *   Parameters: none
     *   Return: n/a
     */
    func showFailDialog(){
        
        SVProgressHUD.dismiss()
        let alert = UIAlertView()
        alert.title = "Name not recognized"
        alert.message = ("Must be T-Rex Employee to use this app")
        alert.addButton(withTitle: "Ok")
        alert.show()
    }
    
    /*
     *   Purpose: Check user input for irregularities
     *   Parameters: none
     *   Return: true if valid input, false otherwise
     */
    func checkUserInput() -> Bool{
        let fname = fname_txt.text!
        let lname = lname_txt.text!
        let password = password_txt.text!
        let checkP = checkPassword_txt.text!
        
        if(fname == ""){
            fname_txt.backgroundColor = UIColor.red
            fname_txt.placeholder = "First name cannot be empty"
            return false
        }
        if (lname == ""){
            lname_txt.backgroundColor = UIColor.red
            lname_txt.placeholder = "Last name cannot be empty"
            return false
        }
        if (password == ""){
            password_txt.backgroundColor = UIColor.red
            password_txt.placeholder = "Password  cannot be empty"
            return false
        }
        if (checkP == ""){
            checkPassword_txt.backgroundColor = UIColor.red
            checkPassword_txt.placeholder = "Password cannot be empty"
            return false
        }
        if (password != checkP){
            password_txt.backgroundColor = UIColor.red
            checkPassword_txt.backgroundColor = UIColor.red
            
            password_txt.placeholder = "Passwords must match"
            checkPassword_txt.placeholder = "Passwords must match"
            return false; //If password and check passwords dont match
        }
        else{
            return true //Else, all input is acceptable
        }
        
        
    }//end function
    
    /*
     *   Purpose: Recieves memory warning
     *   Parameters: none
     *   Return: n/a
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    /*
     *   Purpose: Alternate (working) temp register method
     *   Parameters: none
     *   Return: n/a
     */
    func callRegisterFunction(fname: String, lname: String, pass: String, checkP: String) -> Bool{
        
        
        
        //        _ = [
        //            "username": usernameInput,
        //            "password": passwordInput
        //        ]
        
        if (fname == "Sean" && lname == "Murphy" && pass == "sean_murphy" && checkP == "sean_murphy"){
            return true
        }
        if (fname == "Emily" && lname == "Knowlt" && pass == "password" && checkP == "password"){
            return true
        }
            
        else{
            return false
        }
    }
    
    /*
     *   Purpose: Register functionality with communication to database
            See Helper folder for API code, database communication code
     *   Parameters: none
     *   Return: n/a
     */
    func callRegisterAPI()
    {
        let parameter: NSMutableDictionary = NSMutableDictionary()
        parameter.setValue(fname_txt.text!, forKey: "fname")
        parameter.setValue(lname_txt.text!, forKey: "lname")
        parameter.setValue(password_txt.text!, forKey: "user_pass")
        //parameter.setValue(username_txt.text!, forKey: "user_name")
        SVProgressHUD.show()
        
        API.callApiPOST(strUrl:"register.php",parameter: parameter, success: { (response) in
            
            print(response)
            if response.object(forKey: "status") as! Bool == true
            {
                
                let alert = UIAlertView()
                alert.title = "Register"
                alert.message = (response.object(forKey: "message") as! String)
                alert.addButton(withTitle: "Ok")
                alert.show()
                
                self.performSegue(withIdentifier: "finishAccRegister_seg", sender: self.createAcc_btn)
            }
            else
            {
                let alert = UIAlertView()
                alert.title = "Register"
                alert.message = (response.object(forKey: "message") as! String)
                alert.addButton(withTitle: "Ok")
                alert.show()
            }
            
            SVProgressHUD.dismiss()
        }, error: { (error) in
            print(error)
            SVProgressHUD.dismiss()
            let alert = UIAlertView()
            alert.title = "Register"
            alert.message = error.localizedDescription
            alert.addButton(withTitle: "Ok")
            alert.show()
            // self.custObj.hideSVHud()
        })
        
    }
    
}
