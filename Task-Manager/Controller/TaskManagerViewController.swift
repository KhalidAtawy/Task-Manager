//
//  ViewController.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/26/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//

import UIKit

class TaskManagerViewController: UITableViewController {

    //intialize variables here
    let tasksArray : [Task] = [Task]()
    let itemArray = ["task 1", "task 2", "task 3"]
    
    @IBOutlet var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO: Regirster TaskCell.xib file
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "customTaskCell")
        
        //call configureTableView
        configureTableView()
    }

    
    ///////////////////////////////////////////////////
    //MARK: - Tableview Datasource Methods (numOfRows/ CellForRow)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count //change it to tasksArray
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTaskCell", for: indexPath) as! TaskCell
        
        cell.taskTitle.text = itemArray[indexPath.row]
        //cell.taskTitle.text = tasksArray[indexPath.row].taskTitle
        //cell.completionDate.text = tasksArray[indexPath.row].completionDate
        
        return cell
    }
    
    
    
    //////////////////////////////////////////////////
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    /////////////////////////////////////////////////
    //TODO: Declare configureTableView here:
    
    func configureTableView() {
        taskTableView.rowHeight = UITableView.automaticDimension
        taskTableView.estimatedRowHeight = 120.0
    }
    
    
    
}

