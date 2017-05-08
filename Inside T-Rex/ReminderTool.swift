//
//  ReminderTool.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/23/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//
//  This class allows the user to set reminders. This class handles all functionality
//  regarding adding, removing and creating reminders.

import UIKit
import CoreData
/*
 * Struct to hold reminders
 */
struct reminder{
    var name: String
    var due_date: String
    
    init(name: String, due_date: String)
    {
        self.name = name
        self.due_date = due_date
    }
}

var reminders = [reminder]() //Array of reminder structs
    
class ReminderTool: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Sending reminders is a feature that only paid apple registered developers can use in XCode.
    /*
     *"Second, make sure that you have an active Apple Developer Program Membership, which costs $100/year. It is a requirement in order to send push notifications to your iOS app. Also, make sure Xcode is configured to use the iCloud account which contains your active Apple Developer Program Membership."
    */


    @IBOutlet weak var reminderTable: UITableView!
    
    @IBOutlet weak var reminderLabel_txt: UITextField!
    @IBOutlet weak var reminderDueDate_txt: UIDatePicker!
    
    @IBOutlet weak var cancelAddReminder_btn: UIBarButtonItem!
    @IBOutlet weak var addReminder_btn: UIBarButtonItem!
    
    @IBOutlet weak var doneReminder_btn: UIBarButtonItem!
    var activeTextField = UITextField()

    
    /*
     *   Purpose: Returns user to reminder screen if they hit cancel
     *   Parameters: Button pressed
     *   Return: IBAction
     */
    @IBAction func cancelReminderPressed(_ sender: Any) {
        performSegue(withIdentifier: "doneAddReminder_seg", sender: cancelAddReminder_btn)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
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
    
    /*
     *   Purpose: Functions to remove cells
     *   Parameters: reminder table, edit value
     *   Return: n/a
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            reminders.remove(at: indexPath.row)
            reminderTable.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    //Function to dismiss keyboard on button tap
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
     *   Purpose: returns int containing ordering of Dates
     *   Parameters: reminderTable, number of rows
     *   Return: number of rows (int)
     */
    func checkOrderOfReminders(oldDueDate: Date, inputtedDueDate: Date) -> Int{
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
     *   Purpose: Adds reminder to array of reminder structs
     *   Parameters: reminderTable, number of rows
     *   Return: number of rows (int)
     */
    func addReminder(reminderName: String, due_date: String) {
        print("Got to addReminder method")
        var finalCheckValue: Int?
        print("In addReminder: reminders.count: ",reminders.count)
        if (reminders.count != 0){ //If this is the reminder created, no need to sort
            //Sort reminders
            for i in 0..<reminders.count {
                
                //Due date just entered
                let inputtedDueDate = getDateObject(dueDate: due_date)
                
                //Due date at for loop position
                let dateInArray = reminders[i].due_date
                let oldDueDate = getDateObject(dueDate: dateInArray)
                
                print("Old due date in array is: ",oldDueDate)
                print("Due date to compare to is: ",inputtedDueDate)
                
                finalCheckValue = checkOrderOfReminders(oldDueDate: oldDueDate,inputtedDueDate: inputtedDueDate)
            }
            //If the reminder to input is after the ones already in the array, add to the end
            if (finalCheckValue == 0 || finalCheckValue == 1){
                reminders.append(reminder(name: reminderName, due_date: due_date))
            }
                //If the reminder to input is before the ones already in the array, then add to end, but sort
            else if (finalCheckValue == -1){
                reminders.append(reminder(name: reminderName, due_date: due_date))
                reminders.sort { $0.due_date < $1.due_date }
            }
        }
        else if (reminders.count == 0){
            print("reminders.count = 0. Adding task...")
            reminders.append(reminder(name: reminderName, due_date: due_date))
            print(reminders[0])
        }
    }
    
    /*
     *   Purpose: Segue to take user to add reminder screen
     *   Parameters: Button pressed
     *   Return: IBAction
     */
    
    @IBAction func addReminderPressed(_ sender: Any) {
        performSegue(withIdentifier: "addReminder_seg", sender: addReminder_btn)
    }
    
    /*
     *   Purpose: Color of text field input set to T-Rex colors
     *   Parameters: TextField
     *   Return: n/a
     */
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activeTextField = textField
        activeTextField.backgroundColor = UIColor(red: 187.00, green: 128.00, blue: 74.00, alpha: 1.00)
    }
    
    /*
     *   Purpose: Triggered off user 'Done' button click. Creates a reminder to add
     *   Parameters: button clicked
     *   Return: IBAction
     */

    @IBAction func doneReminderInputPressed(_ sender: Any) {
  
        print("Done reminder input button pressed")
        
        //if user input is valid, create a reminder from data they input
        //return back to reminder table screen
        if(isInputValid() != false){
            
            let name = reminderLabel_txt.text!
            print("Reminder name is: ",name)

            
            let due_date = handler(sender: reminderDueDate_txt)
            print("reminder due date is: ",due_date)
            print("Adding reminder to reminder list...")
            
            addReminder(reminderName: name, due_date: due_date)
            
        }//end check isValid
        
        //added reminder to array, now go back to reminder table to display reminders
        performSegue(withIdentifier: "doneAddReminder_seg", sender: addReminder_btn)
        
    }
    
    /*
     *   Purpose: checks if user entered a reminder name
     *   Parameters: none
     *   Return: true if user entered reminder name, false otherwise
     */
    func isInputValid()-> Bool{
        
        var reminderName: String?
        
        if reminderName != ""{
            reminderName = reminderLabel_txt.text
            return true
        }
        else{
            reminderLabel_txt.backgroundColor = UIColor.red
            reminderLabel_txt.placeholder = "Add a Reminder name"
            return false
        }
    }
    
    /*
     *   Purpose: Parses date from UIDatePicker to string
     *   Parameters: DatePicker to read date from
     *   Return: formatted string date
     */
    func handler(sender: UIDatePicker)->String {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        let strDate = timeFormatter.string(from: reminderDueDate_txt.date)
        //let now = NSDate()
        
        return strDate
    }//end handler method
    
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
     *   Parameters: reminderTable, number of rows
     *   Return: number of rows (int)
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    
    /*
     *   Purpose: Allows for long reminders to be displayed
     *   Parameters: table view cell
     *   Return: n/a
     */
    func allowMultipleLines(tableViewCell: UITableViewCell) {
        
        tableViewCell.textLabel?.numberOfLines = 0
        tableViewCell.textLabel?.lineBreakMode = .byWordWrapping
        
        tableViewCell.detailTextLabel?.numberOfLines = 0
        tableViewCell.detailTextLabel?.lineBreakMode = .byWordWrapping
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     *   Purpose: Populate cells with data from array of reminder structs
     *   Parameters: reminder table, row to insert data
     *   Return: populated cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default Reminders")
        allowMultipleLines(tableViewCell: cell)
        
        //Want text of reminders displayed in the cells to be the bluish color of the app theme.
        //RGB value grabbed from internet on the blue logo.
        //        cell.textLabel?.textColor = UIColor(red: 50.00, green: 72.00, blue: 109.00, alpha: 1.00)
        //        cell.detailTextLabel?.textColor = UIColor(red: 50.00, green: 72.00, blue: 109.00, alpha: 1.00)
        
        print(reminders[indexPath.row].name+" (Due on "+reminders[indexPath.row].due_date+")")
        
        cell.textLabel?.text = reminders[indexPath.row].name+" (Due on "+reminders[indexPath.row].due_date+")"
        
        cell.detailTextLabel!.text = reminders[indexPath.row].due_date
        
        return cell
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
