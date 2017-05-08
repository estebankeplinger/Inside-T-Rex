//
//  OrgChart.swift
//  Inside T-Rex
//
//
//  Created by Esteban Keplinger on 5/1/17.
//  Copyright © 2017 Esteban Keplinger. All rights reserved.
//
//
//
//
//  This class allows the user to see the T-Rex organization chart.
//  Upon load, the user will be shown the organization chart in a table-
//  like structure.

import UIKit

class OrgChart: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var expandTableView: UITableView!
    
    //Replace with employee JSON parsed obects. Missing functionality
    var expandedSections : NSMutableSet = []
    
    
    var sectionData : [String] = ["Zanthia Watts", "Yasmine Glover",  "Yanaye Hairston", "Xavier Byrd-Freeman", "Ivin Hicks", "Jada Talley", "Jake Stenzler","Rose Pompey","Steven Hamilton","Ravi Soodan","Timothy Speight","Amanda Kenney"]
    var row1 = ["William Whichard", "Vish Iyer", "Tre'Nique Mack", "Tom Howe", "Timothy Speight"]
    var row2 = ["Walter Kleidman", "Wardah Akbar", "Susan Little", "Summer Wells", "Steven Hamilton", "Steven Draper", "Adela Castillo"]
    var row3 = ["Anisul Chowdhurry", "Amanda Kenney", "Nikolai Shimer", "Debra Johnson", "Mugda Muley", "Nigeria Harris"]
    var row4 = ["Roger Lyons", "Ronald Radtke", "Renee Stanley", "Ravi Soodan", "Grant Cheung"]
    
    var row1Q : [Int] = [0, 0, 0, 0, 0]
    var row2Q : [Int] = [0, 0, 0, 0, 0, 0, 0, 0]
    var row3Q : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var row4Q : [Int] = [0, 0, 0, 0, 0]
    
    /*
     *   Purpose: Run once view is called
     *   Parameters: none
     *   Return: n/a
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*
     *   Purpose: Memory resource method
     *   Parameters: none
     *   Return: n/a
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     *   Purpose: Method to expand table view
     *   Parameters: none
     *   Return: n/a
     */
    func sectionTapped(_ sender: UIButton) {
        //print("section Tapped")
        let section = sender.tag
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.add(section)
        } else {
            expandedSections.removeAllObjects()
        }
        self.expandTableView.reloadData()
    }
}

/*
 *   Purpose: Extension to allow defining of Prototype Cells
 *   Parameters: none
 *   Return: n/a
 */
extension OrgChart: UITableViewDelegate, UITextFieldDelegate {
    
    
    /*
     *   Purpose: Defines number of sections in table view
     *   Parameters: none
     *   Return: n/a
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    /*
     *   Purpose: Defines Protoype cell attributes
     *   Parameters: none
     *   Return: n/a
     */
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 28))
        var imageView = UIImageView()
        if (expandedSections.contains(section)) {
            imageView = UIImageView.init(frame: CGRect(x: 10, y: 10, width: 18, height: 10))
            imageView.image = UIImage(named: "down-arrow")
        } else {
            imageView = UIImageView.init(frame: CGRect(x: 10, y: 15, width: 10, height: 18))
            imageView.image = UIImage(named: "right-arrow")
        }
        
        let headerTitle = UILabel.init(frame: CGRect(x: 38, y: 4, width: 250, height: 28))
        headerTitle.text = sectionData[section]
        
        let tappedSection = UIButton.init(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height))
        tappedSection.addTarget(self, action: #selector(sectionTapped), for: .touchUpInside)
        tappedSection.tag = section
        
        headerView.addSubview(imageView)
        headerView.addSubview(headerTitle)
        headerView.addSubview(tappedSection)
        
        let swiftColor = UIColor(red: 50.00, green: 72.00, blue: 109.00, alpha: 1.00)
        //Change tableview cell color
        headerView.backgroundColor = swiftColor
        
        return headerView
    }
    
    /*
     *   Purpose: Defines height of table view section header
     *   Parameters: none
     *   Return: n/a
     */
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    /*
     *   Purpose: Returns number of rows in section
     *   Parameters: none
     *   Return: n/a
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return row1.count
            case 1:
                return row2.count
            case 2:
                return row3.count
            default:
                return row4.count
            }
        } else {
            return 0
        }
    }
    
    /*
     *   Purpose: Defines population of table view cells
     *   Parameters: none
     *   Return: n/a
     */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        cell?.selectionStyle = .none
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = "\(row1[indexPath.row]) : \(row1Q[indexPath.row])"
        case 1:
            cell?.textLabel?.text = "\(row2[indexPath.row]) : \(row2Q[indexPath.row])"
        case 2:
            cell?.textLabel?.text = "\(row3[indexPath.row]) : \(row3Q[indexPath.row])"
        case 3:
            cell?.textLabel?.text = "\(row2[indexPath.row]) : \(row2Q[indexPath.row])"
        case 4:
            cell?.textLabel?.text = "\(row1[indexPath.row]) : \(row1Q[indexPath.row])"
        case 5:
            cell?.textLabel?.text = "\(row2[indexPath.row]) : \(row2Q[indexPath.row])"
        case 6:
            cell?.textLabel?.text = "\(row3[indexPath.row]) : \(row3Q[indexPath.row])"


        default:
            cell?.textLabel?.text = "\(row4[indexPath.row]) : \(row4Q[indexPath.row])"
        }
        return cell!;
    }
    
}
