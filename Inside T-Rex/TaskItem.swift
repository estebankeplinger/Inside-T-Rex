//
//  TaskItem.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/3/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//

import UIKit

class TaskItem: NSObject {

    //attributes of a task item
    var taskName: String
    var taskDesc: String
    var taskDueDate: String
    var taskDueTime: String
    var completed: Bool
    
    
    //Function to initialize task item with text
    //Parameters: attributes of a task to initialize
    //Return: initialized task item
    init(taskName: String, taskDesc: String, taskDueDate: String, taskDueTime: String){
        self.taskName = taskName
        self.taskDesc = taskDesc
        self.taskDueDate = taskDueDate
        self.taskDueTime = taskDueTime
        self.completed = false
    }
}
