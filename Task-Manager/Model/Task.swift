//
//  Task.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/26/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//
import Foundation

class Task: Codable {
    //Add task properties here
    
    var taskTitle : String = ""
    var completionDate : String = ""
    var categoryName : String = ""
    var categoryColourIndex : Int = 0
    
    init(text : String, ctgName : String, colourIndex : Int, date : String) {
        
        taskTitle = text
        categoryName = ctgName
        categoryColourIndex = colourIndex
         completionDate = date
        
    }
}
