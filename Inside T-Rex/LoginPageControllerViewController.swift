//
//  LoginPageControllerViewController.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/9/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//
//
//  This class performs all functions associated with allowing the user
//  to log into Inside T-Rex. This class includes funcionality for UI
//  navigation, along with validating user credentials against the 
//  T-Rex database.



import UIKit
import Alamofire

public extension UIView {
    
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.repeatCount = count ?? 3
        animation.duration = (duration ?? 1.0)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        layer.add(animation, forKey: "shake")
    }
}

class LoginPageControllerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var register_btn: UIButton!
    @IBOutlet weak var loginGo_btn: UIButton!
    @IBOutlet weak var loginFeedback_lbl: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var loginHelp_btn: UIButton!
    
    @IBOutlet weak var doneHelp_btn: UIButton!
    
    
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
    
    func setDelegates(){
        userName_txt.delegate = self
        userName_txt.tag = 0
        
        password_txt.delegate = self
        password_txt.tag = 1
        
    }
    
    /*
     *   Purpose: Dismisses keyboard on user tap outside of text field
     *   Parameters: none
     *   Return: n/a
     */
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginHelpPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToHelp_seg", sender: loginHelp_btn)
    }
    
    
    @IBAction func doneHelpPressed(_ sender: Any) {
        performSegue(withIdentifier: "helpToLogin_seg", sender: loginHelp_btn)
    }
    
    
    /*
     *   Purpose: Moves cursor to password text field on enter key hit
     *   Parameters: Text field
     *   Return: boolean
     */
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
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
        SVProgressHUD.show()
        
        let usernameInput: String = userName_txt.text!
        let passwordInput: String = password_txt.text!
        
        //Check for username input
        if(usernameInput == "")
        {
            //userName_txt.backgroundColor = UIColor.red
            userName_txt.placeholder = "User name cannot be empty"
            userName_txt.shake()
            if(passwordInput == ""){
                password_txt.placeholder = "Password cannot be empty"
                password_txt.shake()
                SVProgressHUD.dismiss()

            }
            return
        }
        //check for password input
        if (passwordInput == ""){
            password_txt.placeholder = "Password cannot be empty"
            password_txt.shake()
            SVProgressHUD.dismiss()
            return
        }
        
        //Log user in
        if (callLoginFunction(usernameInput: usernameInput,passwordInput: passwordInput) == true){
            
            _ = Timer.scheduledTimer(timeInterval: 2.3, target: self, selector: #selector(loadHomeScreen), userInfo: nil, repeats: false)
            
        }
        else{
            _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showFailDialog), userInfo: nil, repeats: false)
        }
        
        //This goes back into the commented part
        //performSegue(withIdentifier: "goPressed_seg", sender: loginGo_btn)
        
    }//end function
    
    
    /*
     *   Purpose: Load home screen after log in
     *   Parameters: none
     *   Return: n/a
     */
    func loadHomeScreen(){
        SVProgressHUD.dismiss()
        performSegue(withIdentifier:"goPressed_seg", sender: self)
        
    }
    
    /*
     *   Purpose: User login fail dialog
     *   Parameters: none
     *   Return: n/a
     */
    func showFailDialog(){
        
        SVProgressHUD.dismiss()
        let alert = UIAlertView()
        alert.title = "Login Failed"
        alert.message = ("Invalid Login Credentials")
        alert.addButton(withTitle: "Ok")
        alert.show()
    }
    
    var employeeDict: NSDictionary?
    var returnValue = 9
    
    /*
     *   Purpose: Function to log user into the app
            Missing: Parse JSON objects into the employee dictionary.
            Able to grab JSON, but not parse the data into the Dictionary
     *   Parameters: none
     *   Return: n/a
     */
    func callLoginFunction(usernameInput: String, passwordInput: String) -> Bool{
        
        //test users
        if (usernameInput == "Thomas-Bradshaw" && passwordInput == "password"){
            return true
        }
        if (usernameInput == "Bob-Earl" && passwordInput == "spongebob"){
            return true
        }
        if (usernameInput == "fname-lname" && passwordInput == "password"){
            return true
        }
        if (usernameInput == "Sean-Murphy" && passwordInput == "sean_murphy"){
            return true
        }
        if (usernameInput == "Emily-Knowlt" && passwordInput == "password"){
            return true
        }
        
        checkDatabaseUser(usernameInput: usernameInput,passwordInput: passwordInput)
        if (returnValue == 0){
            return true
        }
        return false

        
    }//end method
    
    
    func checkDatabaseUser(usernameInput: String, passwordInput: String) {
        Alamofire.request("http://ekepling.cs.loyola.edu/employee.php", method: .post, encoding: JSONEncoding.default).validate().responseString{
            response in
            print("Request: \(String(describing: response.request))")  // original URL request
            print("Response: \(String(describing: response.response))") // HTTP URL response
            print("Data: \(String(describing: response.data))")     // server data
            //print("Result: \(String(describing: response.result.value))")   // result of response serialization
            print("Error: \(String(describing: response.error))")
            
            //if json array contains username input and password in same dictionary, valid login
            let json = response.result.value
            print(type(of: json))
            if ((json?.contains(usernameInput))! && (json?.contains(passwordInput))!){
                self.returnValue = 0
            }

        }
    }

    /*
     *   Purpose: Parse JSON to dictionary
     *   Parameters: JSON text data (in a string)
     *   Return: Parsed employee dictionary
     */
    func convertToDictionary(text: String) -> [String: Any]? {
        
        //print("Text is: ", text)
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    /*
     *   Purpose: Checks username field input against database record
     *   Parameters: username string
     *   Return: true if username matches database records,
     false otherwise
     */
    func checkUsername(usernameInput: String)-> Bool{
        
        return true; //Add authentication functionality
    }
    
    /*
     *   Purpose: Checks password field input against database record
     *   Parameters: password string
     *   Return: true if password matches database records,
     false otherwise
     */
    func checkPassword(passwordInput: String)-> Bool{
        return true; //Add authentication functionality
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
     *   Purpose: Validates user login, register with database communication
            See Helper folder for database communication code
     *   Parameters: none
     *   Return: n/a
     */
    //func callLoginAPI()
    //{
    //    let parameter: NSMutableDictionary = NSMutableDictionary()
    //    parameter.setValue(password_txt.text!, forKey: "user_pass")
    //    parameter.setValue(userName_txt.text!, forKey: "user_name")
    //    SVProgressHUD.show()
    //
    //    API.callApiPOST(strUrl:"login.php",parameter: parameter, success: { (response) in
    //
    //        print(response)
    //        if response.object(forKey: "status") as! Bool == true
    //        {
    //
    //            let alert = UIAlertView()
    //            alert.title = "Login"
    //            alert.message = (response.object(forKey: "message") as! String)
    //            alert.addButton(withTitle: "Ok")
    //            alert.show()
    //
    //            self.performSegue(withIdentifier: "goPressed_seg", sender: self.loginGo_btn)
    //        }
    //        else
    //        {
    //            let alert = UIAlertView()
    //            alert.title = "Login"
    //            alert.message = (response.object(forKey: "message") as! String)
    //            alert.addButton(withTitle: "Ok")
    //            alert.show()
    //        }
    //        
    //        SVProgressHUD.dismiss()
    //    }, error: { (error) in
    //        print(error)
    //        SVProgressHUD.dismiss()
    //        let alert = UIAlertView()
    //        alert.title = "Login"
    //        alert.message = error.localizedDescription
    //        alert.addButton(withTitle: "Ok")
    //        alert.show()
    //        // self.custObj.hideSVHud()
    //    })
    //    
    //}//end call API
    
}//end class

final class Shared {
    static let shared = Shared() //lazy init, and it only runs once
    
    var employeeFName : String!
    var employeeLName : String!
    var employeeBio: String!
    var employeeUserName: String!
    
}












