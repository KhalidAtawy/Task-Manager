//
//  ViewController.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/26/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//

import UIKit

class TaskManagerViewController: UITableViewController, AddTask {
    

    //intialize variables here
  //  var allTasks = taskBank ()
    var taskList = [Task] ()
    
    var itemArray = ["task 1", "task 2", "task 3"]
    
    
    @IBOutlet var taskTableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO: Regirster TaskCell.xib file
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "customTaskCell")
        
        //call configureTableView
        configureTableView()
        
        
        if let items = defaults.array(forKey: "ListArray") as? [Task] {
            taskList = items
        }
        
    }

    
    ///////////////////////////////////////////////////
    //MARK: - Tableview Datasource Methods (numOfRows/ CellForRow)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return itemArray.count //change it to tasksArray
        
        return taskList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTaskCell", for: indexPath) as! TaskCell
        
        //for using the testing arary
        //cell.taskTitle.text = itemArray[indexPath.row]
        
        cell.taskTitle.text = taskList[indexPath.row].taskTitle
        cell.completionDate.text = taskList[indexPath.row].completionDate
        
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
        
        //Open details screen if clicked on the task
        performSegue(withIdentifier: "goToDetailScreen", sender: self)
    }

    
    /////////////////////////////////////////////////
    //TODO: Declare configureTableView here:
    
    func configureTableView() {
        taskTableView.rowHeight = UITableView.automaticDimension
        taskTableView.estimatedRowHeight = 120.0
    }
    
    
    
    /////////////////////////////////////////////
    
    //MARK: - Settings button pressed
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToSettingsScreen", sender: self)
    }
    

    //MARK: - Add button pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToDetailScreen", sender: self)
                
    }

    
    //MARK:- addTask function
    func addTask(nameTxt: String, ctgNameTxt: String, ctgColourTxt: String, completionDateTxt: String) {
        taskList.append(Task(text: nameTxt, ctgName: ctgNameTxt, colour: ctgNameTxt, date: completionDateTxt))
        
        defaults.set(taskList, forKey: "ListArray")
        
        tableView.reloadData()
        
    }
    
    // allows other viewController to edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! taskDetailsViewController
        vc.addTaskDelegate = self
        
    }
}

