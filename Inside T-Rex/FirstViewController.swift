//
//  FirstViewController.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/3/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//

import UIKit

struct task{
    var name = "Name"
    var desc = "Description"
    var due_date = "mm/dd/yy"
    
}

var taskMgr: TaskManager = TaskManager()


class FirstViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var taskTable: UITableView!
    @IBOutlet weak var taskName_txt: UITextField!
    @IBOutlet weak var taskDesc_txt: UITextField!
    @IBOutlet weak var taskDueDate_txt: UIDatePicker!
    @IBOutlet weak var taskDone_btn: UIBarButtonItem!
    @IBOutlet weak var addTask_btn: UIBarButtonItem!
    
    //Cancel task button function
    @IBAction func cancelTask_btn(_ sender: Any) {
        performSegue(withIdentifier: "backToTasks_seg", sender: cancelTask_btn)
    }
    var taskList = [TaskItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //taskTable.reloadData()
        
    }
    
    @IBAction func addTaskPressed(_ sender: Any) {
        performSegue(withIdentifier: "addTask_seg", sender: taskDone_btn)
    }
//    @IBAction func dueDateChanged(_ sender: Any) {
//        var date = taskDueDate_txt.date
//        
//    }
    var activeTextField = UITextField()

    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activeTextField = textField
        activeTextField.backgroundColor = UIColor(red: 187.00, green: 128.00, blue: 74.00, alpha: 1.00)
    }
    
    
    /*
     *   Purpose: Triggered off user 'Done' button click
            Creates a task to add
     *   Parameters: button clicked
     *   Return: n/a
     */
    @IBAction func doneTaskInput_btn(_ sender: Any) {
        
        
        //if user input is valid, create a task from data they input
        //return back to task table screen
        if(isInputValid() != false){
            
            var TaskStruct = task()
            TaskStruct.name = taskName_txt.text!
            TaskStruct.desc = taskDesc_txt.text!
            TaskStruct.due_date = handler(sender: taskDueDate_txt)
            
            TaskManager().addTask(name: TaskStruct.name, desc: TaskStruct.desc, due_date: TaskStruct.due_date)
            
        }//end check isValid
        
        //added task to array, now go back to task table to display tasks
        performSegue(withIdentifier: "backToTasks_seg", sender: taskDone_btn)
        
        
    }//end function
    
    
    /*
    *   Purpose: checks if user entered a task name
    *   Parameters: none
    *   Return: true if user entered task name
            false otherwise
    */
    func isInputValid()-> Bool{
        
        var taskName: String?
        
        if taskName != ""{
            taskName = taskName_txt.text
            return true
        }else{
            taskName_txt.backgroundColor = UIColor.red
            taskName_txt.placeholder = "Add a task name"
            return false
        }

    }//end isInputValid method
    
    /*
     *   Purpose: Parses date from UIDatePicker to string
     *   Parameters: DatePicker to read date from
     *   Return: formatted string date
     */
    func handler(sender: UIDatePicker)->String {

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd-MM-yyyy HH:mm"

        let strDate = timeFormatter.string(from: taskDueDate_txt.date)
        
        return strDate
    }//end handler method
    
    /*
     *   Purpose: Populate cells with data from array of task structs
     *   Parameters: task table, row to insert data
     *   Return: populated cell
     */
    func tableView(taskTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default Tasks")
        
        cell.textLabel?.text = taskMgr.tasks[indexPath.row].name
        cell.detailTextLabel?.text = taskMgr.tasks[indexPath.row].desc
        
        return cell
    }
    
    /*
     *   Purpose: Remove cell
     *   Parameters: task table, edit value
     *   Return: n/a
     */
    func tableView(taskTable: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if (editingStyle == UITableViewCellEditingStyle.delete){
            
            taskMgr.tasks.remove(at: indexPath.row)
            taskTable.reloadData()
        }
    }
    
    /*
     *   Purpose: Returns number of sections (columns) in table
     *   Parameters: table
     *   Return: number of sections (colums)
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print( "setting number of sections");
        return 3
    }

    /*
     *   Purpose: Returns number of rows in array to the table view
     *   Parameters: taskTable, number of rows
     *   Return: number of rows (int)
     */
    func tableView(taskTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( "setting number of rows");
        return taskMgr.tasks.count; // taskList.count
    }

}//end FirstViewController class



class TaskManager: NSObject {
    var tasks = [task]()
    
    
    /*
     *   Purpose: Add new task to task array
     *   Parameters: task (struct) to add
     *   Return: n/a
     */
    func addTask(name: String, desc: String, due_date: String){
        tasks.append(task(name: name, desc: desc, due_date: due_date))
    }
    //MyData(company: "Joes Crab Shack", city: "Miami", state: "FL", latitude: 30.316599, longitude: -119.050254)
    

    //Function to remove task from task array
    //Input: task to remove
    //Output: Task removed successfully
    //Runtime: O(n)
    
//    func removeTask(takTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath,
//                    row: Int){
//        
//     }
    
    
}



