//
//  TaskManager.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/3/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//

import UIKit

var taskManager: TaskManager = TaskManager()

struct task{
    var name = "Name"
    var desc = "Description"
    var due_date = "mm/dd/yy"
    var due_time = "hh:mm"
    
}
class TaskManager: NSObject {
    var tasks = [task]()
    
    //Function to add new task to task array
    //Input: task to add
    //Output: Task added successfully
    //Runtime: O(n)
    func addTask(name: String, desc: String, due_date: String, due_time: String){
        tasks.append(task(name: name, desc: desc, due_date: due_date, due_time: due_time))
    }
    
    //Function to remove task from task array
    //Input: task to remove
    //Output: Task removed successfully
    //Runtime: O(n)
    /*
    func removeTask(name: String){
        
        tasks.remove(at: <#T##Int#>)
    }*/
    
    
}
