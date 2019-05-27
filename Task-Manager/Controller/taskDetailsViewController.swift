//
//  addTaskViewController.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/27/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//

import UIKit

protocol AddTask {
    func addTask(nameTxt : String, ctgNameTxt : String, ctgColourTxt : String, completionDateTxt : String)
}

class taskDetailsViewController: UIViewController {
    
    // var allTasks = taskBank ()
    var taskManager = TaskManagerViewController ()
    
    
    var addTaskDelegate:AddTask?
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var categoryNameText: UITextField!
    @IBOutlet weak var categoryColourText: UITextField!
    @IBOutlet weak var completionDateText: UITextField!
    
    
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    //MARK: - Save Button Pressed
    @IBAction func SaveButtonPressed(_ sender: Any) {
        
        //allTasks.tasksArray.append(Task(text: nameText.text!, date: completionDateText.text!, ctgName: categoryNameText.text!, colour: categoryNameText.text!))
       // taskManager.tableView.reloadData()
        
        addTaskDelegate?.addTask(nameTxt: nameText.text!, ctgNameTxt: categoryNameText.text!, ctgColourTxt: categoryNameText.text!, completionDateTxt: completionDateText.text!)
        
       
    }
    

    
}

