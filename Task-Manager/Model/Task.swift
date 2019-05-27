//
//  Task.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/26/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//

class Task {
    //Add task properties here
    
    var taskTitle : String
    var completionDate : String
    var categoryName : String
    var categoryColour : String
    
    init(text : String, ctgName : String, colour : String, date : String) {
        
        taskTitle = text
        categoryName = ctgName
        categoryColour = colour
         completionDate = date
        
    }
}
