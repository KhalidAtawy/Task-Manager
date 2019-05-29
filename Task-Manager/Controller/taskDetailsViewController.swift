//
//  addTaskViewController.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/27/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//

import UIKit

protocol AddInsertDeleteTask {
    func addInsertDeleteTask(nameTxt : String, ctgNameTxt : String, colourIndexTxt : Int, completionDateTxt : String, isDelete: Bool)
}

protocol LeaveTaskDetailVC {
    func leaveTaskDetailVC (cell_pressed: Bool)
}

class taskDetailsViewController: UIViewController {
    
    
    var addInsertDeleteTaskDelegate:AddInsertDeleteTask?
    var leaveVC_Delegate:LeaveTaskDetailVC?
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var categoryNameText: UITextField!
    @IBOutlet weak var categoryColourText: UITextField!
    @IBOutlet weak var completionDateText: UITextField!

    private var datePicker: UIDatePicker?
    
    
    var name: String = ""
    var category: String = ""
    var colour: String = ""
    var date: String = ""
    var pressed: Bool = false
    
    let colourArray = ["red",
                       "green",
                       "blue"]
    let UIColoursArray : [UIColor] = [.red,
                                      .green,
                                      .blue]
    var selectedColour: UIColor?
    
    let categoryArray = ["Sport",
                         "Work",
                         "Other"]
    var selectedCategory: String?
    
    var selectedColourIndex: Int = 0
    
    override func viewDidLoad() {
        
        //MARK: - Call pickerViews
       createDatePicker()
        
        
        
        
        
        createCategoryPicker()
        //createColourPicker()
//////////////////////////////////////////////////////////
        //Check if task was pressed to edit
        if pressed == true {
            nameText.text! = name
            categoryNameText.text! = category
            //categoryColourText.text! = colour
            categoryColourText.backgroundColor = UIColoursArray[selectedColourIndex]
            completionDateText.text! = date
            
            pressed = false
        } else {
            clearTexts()
        }
        
    }
    

    //MARK: - Save Button Pressed
    @IBAction func SaveButtonPressed(_ sender: Any) {
        
        //allTasks.tasksArray.append(Task(text: nameText.text!, date: completionDateText.text!, ctgName: categoryNameText.text!, colour: categoryNameText.text!))
       // taskManager.tableView.reloadData()
        
        addInsertDeleteTaskDelegate?.addInsertDeleteTask(nameTxt: nameText.text!, ctgNameTxt: categoryNameText.text!, colourIndexTxt: selectedColourIndex, completionDateTxt: completionDateText.text!, isDelete: false)
    }
    
   

    //MARK: - trashButtonPressed to delete the task
    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        
        clearTexts()
        //self.view.setNeedsDisplay()
        addInsertDeleteTaskDelegate?.addInsertDeleteTask(nameTxt: nameText.text!, ctgNameTxt: categoryNameText.text!, colourIndexTxt: selectedColourIndex, completionDateTxt: completionDateText.text!, isDelete: true)
        
    }
    
    // trigger if leaving the ViewController after editing to clear the texts
    override func viewWillDisappear(_ animated: Bool) {
        leaveVC_Delegate?.leaveTaskDetailVC(cell_pressed: false)
    }
    
    
    //func that clear the texts
    func clearTexts() {
        nameText.text! = ""
        categoryNameText.text! = ""
        categoryColourText.text! = ""
        completionDateText.text! = ""
    }
    
    
    //MARK: - createDatePicker
    func createDatePicker() {
        //setting the datePicker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector (taskDetailsViewController.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (taskDetailsViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        completionDateText.inputView = datePicker
    }
    
    //MARK: - DatePicker Related functions (dateChanged and viewTapped)
    @objc func dateChanged (datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm/dd/yyyy"
        
        completionDateText.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
    }
    // check if the view got tapped
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    //MARK: - PickerView functions
//    func createColourPicker() {
//
//        //setting colour pickerView
//    let colourPickerView = UIPickerView()
//        colourPickerView.delegate = self
//        categoryColourText.inputView = colourPickerView
//
//    }
    //MARK: - CreateCategoryPicker
    func createCategoryPicker() {
        
        //setting colour pickerView
        let categoryPickerView = UIPickerView()
        categoryPickerView.delegate = self
        categoryNameText.inputView = categoryPickerView
        
    }

}

extension taskDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return UIColoursArray.count //for colour pickerview - actually its the same size
        return categoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return colourArray[row] // for colour pickerView
        return categoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedColour = UIColoursArray[row] //for colour pickerView
        categoryColourText.backgroundColor = selectedColour

        selectedCategory = categoryArray[row]
        categoryNameText.text = selectedCategory
        
        selectedColourIndex = row
    }
}
