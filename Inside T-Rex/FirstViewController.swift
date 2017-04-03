//
//  FirstViewController.swift
//  Inside T-Rex
//
//  Created by Esteban Keplinger on 4/3/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var taskList = [TaskItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
}

/*
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.

        if taskList.count > 0{
            return
        }
        
        //taskList.append(TaskItem(taskName: "Task 1", taskDesc: "New Task desc", taskDueDate: "04/29/95", taskDueTime: "09:30"))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    internal func tableView(_ tableView: UITableView,
                           cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        let item = taskList[indexPath.row]
        cell.textLabel?.text = item.taskName
        return cell
    }

    
    
}
*/
