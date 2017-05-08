//
//  HelpScreen.swift
//  Inside T-Rex
//
//
//
//  Created by Esteban Keplinger on 2/12/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//  This class shows the user the help screen upon them tapping
//  on the main login page. Most code for this is done in via the storyboard.
//  Helper functions are located below

import Foundation
import UIKit

class HelpScreen: UIViewController{
    

    @IBOutlet weak var doneHelp_btn: UIButton!

    /*
     *   Purpose: Takes user back to login page
     *   Parameters: none
     *   Return: n/a
     */
    @IBAction func doneHelpPressed(_ sender: Any) {
        performSegue(withIdentifier: "helpToLogin_seg", sender: doneHelp_btn)
    }
    
    
//    @IBAction func helpBackButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "backToLogin_seg", sender: backToLogin_btn)
//    }
}
