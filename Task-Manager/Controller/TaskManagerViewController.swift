//
//  ViewController.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/26/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//

import UIKit
import UserNotifications



class TaskManagerViewController: UITableViewController, AddInsertDeleteTask, LeaveTaskDetailVC {
    
    

    //intialize variables here
    //var itemArray = ["task 1", "task 2", "task 3"]
  //  var allTasks = taskBank ()
    
    let UIColoursArray : [UIColor] = [.red,
                                      .green,
                                      .blue]
    var selectedColourIndex: Int = 0
    
    var taskList = [Task]()
    var cellPressed : Bool = false
    var cellPressedIndex : Int = 0
    
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Tasks.plist")
    
    @IBOutlet var taskTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view, typically from a nib.
        print(dataFilePath!)
        //TODO: Regirster TaskCell.xib file
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "customTaskCell")
        
        //call configureTableView
        configureTableView()
        
        loadItems()
        
        tableView.separatorStyle = .none
        
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
        cell.categoryColour.backgroundColor = UIColoursArray[taskList[indexPath.row].categoryColourIndex]
        
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
        
        //prepare data for edit
        cellPressed = true
        cellPressedIndex = indexPath.row
        
        //Open details screen if clicked on the task to edit
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
        cellPressed = false
        performSegue(withIdentifier: "goToDetailScreen", sender: self)
                
    }

    
    //MARK:- Protocol Methods (addInsertDeleteTask function - leaveTaskDetailVC)
    func addInsertDeleteTask(nameTxt: String, ctgNameTxt: String, colourIndexTxt: Int, completionDateTxt: String, isDelete: Bool) {
        
        if isDelete == false {
            if cellPressed != true {
                
                taskList.append(Task(text: nameTxt, ctgName: ctgNameTxt, colourIndex: colourIndexTxt, date: completionDateTxt))
                selectedColourIndex = colourIndexTxt

                
            } else {
                taskList.insert(Task(text: nameTxt, ctgName: ctgNameTxt, colourIndex: colourIndexTxt, date: completionDateTxt), at: cellPressedIndex)
                
                taskList.remove(at: cellPressedIndex + 1)
                cellPressed = false
            }
        } else {
            taskList.remove(at: cellPressedIndex)
        }
        saveItems()
    }
    
    //
    func leaveTaskDetailVC(cell_pressed: Bool) {
        cellPressed = cell_pressed
    }
    
    
    
    
    //MARK: - prepareForSegue allows other viewController to edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailScreen" {
            let taskDetailVC = segue.destination as! taskDetailsViewController
            taskDetailVC.addInsertDeleteTaskDelegate = self
            taskDetailVC.leaveVC_Delegate = self
            
            if cellPressed == true {
                
                taskDetailVC.name = taskList[cellPressedIndex].taskTitle
                taskDetailVC.category = taskList[cellPressedIndex].categoryName
                taskDetailVC.selectedColourIndex = taskList[cellPressedIndex].categoryColourIndex
                taskDetailVC.date = taskList[cellPressedIndex].completionDate
                taskDetailVC.pressed = cellPressed
                print(taskDetailVC.name)

            }
        }
        
    }
    
    //MARK: - Model Manupulation Methods ( Saving"encoding" and Loading"decoding" data)
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(taskList)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array,\(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            taskList = try decoder.decode([Task].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
    
    //MARK: - applying swipe - remove to cell
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskList.remove(at: indexPath.row)
            saveItems()
        }
    }
    
    
    
    
}

