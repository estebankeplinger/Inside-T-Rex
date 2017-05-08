//
//  Profile.swift
//  Inside T-Rex
//
//
//  Created by Esteban Keplinger on 5/1/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//  This class allows the user to view his/her profile. It allows the user to manage
//  their profile, while also allowing them to sign out from this class. Most code located
//  in interface builder. (storyboard)

import UIKit

class Profile: UIViewController {

    @IBOutlet weak var employeeName_lbl: UILabel!
    @IBOutlet weak var employeeUserName_lbl: UILabel!
    
    @IBOutlet weak var managerFeedback_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
     *   Purpose: Receives memory warning
     *   Parameters: None
     *   Return: n/a
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     *   Purpose: Loads employee first name, last name username, bio
            Populates employee profile screen
     *   Parameters: None
     *   Return: n/a
     */
    func loadEmployeeData(){
        
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
