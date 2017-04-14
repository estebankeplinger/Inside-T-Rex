//
//  Register.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/10/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//

import UIKit

class Register: UIViewController {

    
    @IBOutlet weak var logoImage_img: UIImageView!
    
    @IBOutlet weak var createAccount_lbl: UILabel!
    
    @IBOutlet weak var emailInstruct_lbl: UILabel!
    @IBOutlet weak var email_txt: UITextField!
    
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

        //loadRegisterConstraints()
        
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
     *   Purpose: Segue to take user back to login page
     *   Parameters: Cancel button pressed
     *   Return: n/a
     */
    @IBAction func backToLogin(_ sender: Any) {
        performSegue(withIdentifier: "backFromRegister_seg", sender: backFromReg_btn)
    }
    
    /*
     *   Purpose: Segue to take user back to login page
            Saves inputted information, creates account
     *   Parameters: Create account button
     *   Return: n/a
     */
    @IBAction func createAccount(_ sender: Any) {
        
        performSegue(withIdentifier: "finishAccRegister_seg", sender: createAcc_btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRegisterConstraints(){
        
//        let logoConstraint = NSLayoutConstraint(item:logoImage_img,
//        attribute: .centerX,
//        relatedBy: .equal,
//        toItem: self.view,
//       attribute: .left,
//       multiplier: 1.0,
//       constant: 0.0);
//       view.addConstraint(logoConstraint);
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
