//
//  FirstViewController.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 3/2/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//
//  This class controlls the Task Tool feature of Inside T-Rex.
//  a user is able to add, delete and create new tasks that are added to
//  the task table view
//


import UIKit
import CoreData

/*
 * Struct to hold tasks
 */
struct task{
    var name: String
    var desc: String
    var due_date: String
    
    init(name: String, desc: String, due_date: String)
    {
        self.name = name
        self.desc = desc
        self.due_date = due_date
    }
}
var tasks = [task]() //Array of task structs

var context: NSManagedObjectContext?{
    return (UIApplication.shared.delegate as? AppDelegate)?
        .persistentContainer.viewContext
}

/*
 *   Purpose: Handles task tool functionality, displays task in UITableView
 *
 *   
 */
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var taskTable: UITableView!
    
    @IBOutlet weak var taskName_txt: UITextField!
    @IBOutlet weak var taskDesc_txt: UITextField!
    @IBOutlet weak var taskDueDate_txt: UIDatePicker!
    @IBOutlet weak var taskDone_btn: UIBarButtonItem!
    @IBOutlet weak var addTask_btn: UIBarButtonItem!
    
    var activeTextField = UITextField()
    
    /*
     *   Purpose: Returns user to task screen if they hit cancel
     *   Parameters: Button pressed
     *   Return: IBAction
     */
    @IBAction func cancelTask_btn(_ sender: Any) {
        performSegue(withIdentifier: "backToTasks_seg", sender: cancelTask_btn)
    }
    
    /*
     *   Purpose: Run upon view loading
     *   Parameters: n/a
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //setDelegates()
        //taskTable.reloadData()
        //taskTable.reloadData()
    }
    
    /*
     *   Purpose: Takes string date, returns Date object
     *   Parameters: String date
     *   Return: Date object from string date
     */
    func getDateObject(dueDate: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let date = dateFormatter.date(from: dueDate)
        
        return date!
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
     *   Purpose: returns int containing ordering of Dates
     *   Parameters: taskTable, number of rows
     *   Return: number of rows (int)
     */
    func checkOrderOfTasks(oldDueDate: Date, inputtedDueDate: Date) -> Int{
        //due dates are equal
        if(inputtedDueDate == oldDueDate){
            print("Dates are the same")
            return 0
        }
        //due date is before than date in array
        else if (inputtedDueDate < oldDueDate){
            return -1
        }
        //due date is greater than date in array
        else{
            return 1
        }
    }
    
    /*
     *   Purpose: Adds task to array of task structs
     *   Parameters: taskTable, number of rows
     *   Return: number of rows (int)
     */
    func addTask(name: String, desc: String, due_date: String) {
        
        var finalCheckValue: Int?
        
        if (tasks.count != 0){ //If this is the first take created, no need to sort
            //Sort tasks
            for i in 0..<tasks.count {
                
                //Due date just entered
                let inputtedDueDate = getDateObject(dueDate: due_date)
            
                //Due date at for loop position
                let dateInArray = tasks[i].due_date
                let oldDueDate = getDateObject(dueDate: dateInArray)
            
                print("Old due date in array is: ",oldDueDate)
                print("Due date to compare to is: ",inputtedDueDate)
            
                finalCheckValue = checkOrderOfTasks(oldDueDate: oldDueDate,inputtedDueDate: inputtedDueDate)
            }
            //If the task to input is after the ones already in the array, add to the end
            if (finalCheckValue == 0 || finalCheckValue == 1){
                tasks.append(task(name: name, desc: desc, due_date: due_date))
            }
            //If the task to input is before the ones already in the array, then add to end, but sort
            else if (finalCheckValue == -1){
                tasks.append(task(name: name, desc: desc, due_date: due_date))
                tasks.sort { $0.due_date < $1.due_date }
            }
        }
        else if (tasks.count == 0){
            tasks.append(task(name: name, desc: desc, due_date: due_date))
        }
    }
    
    /*
     *   Purpose: Segue to take user to add a task screen
     *   Parameters: Button pressed
     *   Return: IBAction
     */
    @IBAction func addTaskPressed(_ sender: Any) {
        performSegue(withIdentifier: "addTask_seg", sender: addTask_btn)
    }

    /*
     *   Purpose: Color of text field input set to T-Rex colors
     *   Parameters: TextField
     *   Return: n/a
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
        activeTextField.backgroundColor = UIColor(red: 187.00, green: 128.00, blue: 74.00, alpha: 1.00)
    }
    
    
    /*
     *   Purpose: Triggered off user 'Done' button click. Creates a task to add
     *   Parameters: button clicked
     *   Return: IBAction
     */
    @IBAction func doneTaskInput_btn(_ sender: Any) {
        print("Done task input button pressed")
        
        //if user input is valid, create a task from data they input
        //return back to task table screen
        if(isInputValid() != false){
            
            let name = taskName_txt.text!
            print("Task name is: ",name)
            let desc = taskDesc_txt.text!
            print("Task desc is: ",desc)

            let due_date = handler(sender: taskDueDate_txt)
            print("Task due date is: ",due_date)
            print("Adding task to task list...")

            addTask(name: name, desc: desc, due_date: due_date)
            
        }//end check isValid
        
        //added task to array, now go back to task table to display tasks
        performSegue(withIdentifier: "backToTasks_seg", sender: taskDone_btn)
    }//end function
    
    /*
    *   Purpose: checks if user entered a task name
    *   Parameters: none
    *   Return: true if user entered task name, false otherwise
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
        //let now = NSDate()
        
        return strDate
    }//end handler method
    
    
    /*
     *   Purpose: Functions to remove cells
     *   Parameters: task table, edit value
     *   Return: n/a
     */
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            tasks.remove(at: indexPath.row)
            taskTable.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    /*
     *   Purpose: Returns number of sections (columns) in table
     *   Parameters: table
     *   Return: number of sections (colums)
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print( "setting number of sections");
        return 1
    }

    /*
     *   Purpose: Returns number of rows in array to the table view
     *   Parameters: taskTable, number of rows
     *   Return: number of rows (int)
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count // taskList.count
    }
    
    /*
     *   Purpose: Allows for long tasks to be displayed
     *   Parameters: table view cell
     *   Return: n/a
     */
    func allowMultipleLines(tableViewCell: UITableViewCell) {

        tableViewCell.textLabel?.numberOfLines = 0
        tableViewCell.textLabel?.lineBreakMode = .byWordWrapping
        
        tableViewCell.detailTextLabel?.numberOfLines = 0
        tableViewCell.detailTextLabel?.lineBreakMode = .byWordWrapping
    }
    
    /*
     *   Purpose: Populate cells with data from array of task structs
     *   Parameters: task table, row to insert data
     *   Return: populated cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default Tasks")
        allowMultipleLines(tableViewCell: cell)

        //Want text of tasks displayed in the cells to be the bluish color of the app theme.
        //RGB value grabbed from internet on the blue logo.
//        cell.textLabel?.textColor = UIColor(red: 50.00, green: 72.00, blue: 109.00, alpha: 1.00)
//        cell.detailTextLabel?.textColor = UIColor(red: 50.00, green: 72.00, blue: 109.00, alpha: 1.00)

        
        cell.textLabel?.text = tasks[indexPath.row].name+" (Due on "+tasks[indexPath.row].due_date+")"
        cell.detailTextLabel!.text = tasks[indexPath.row].desc
        
        return cell
    }
    

}//end FirstViewController class



