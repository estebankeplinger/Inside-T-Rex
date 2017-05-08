//
//  LaunchScreen.swift
//  Inside T-Rex
//
//
//  Created by Esteban Keplinger on 4/12/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//
//  This class displays the launch screen to the user upon app load
//  Most code for this functionality is done via the storyboard.

import Foundation
import UIKit
//MARK: Properties



class LaunchScreen: UIViewController {

    
    /*
     *   Purpose: Shows launch screen while app loads
     *   Parameters: none
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(loadLoginPage), userInfo: nil, repeats: false)
        
        return
    }

    /*
     *   Purpose: Launch screen
     *   Parameters: none
     *   Return: n/a
     */
    func loadLoginPage(){
        self.performSegue(withIdentifier:"launchScreen_seg", sender: self)

    }
    
    
}
