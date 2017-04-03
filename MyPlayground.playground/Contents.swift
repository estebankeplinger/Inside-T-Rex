//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


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
        print("Hello here")
        tasks.append(task(name: name, desc: desc, due_date: due_date, due_time: due_time))

    }

    

}




