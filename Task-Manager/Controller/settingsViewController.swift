//
//  settingsViewController.swift
//  Task-Manager
//
//  Created by Khalid Saleh Elatawy on 5/27/19.
//  Copyright © 2019 Khalid Saleh Elatawy. All rights reserved.
//

import UIKit
import UserNotifications

class settingsViewController: UIViewController  {
    
    let defaults = UserDefaults.standard
  
    
    override func viewDidLoad() {
        
        //MARK: - Notification Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
        }
        if let switchState = defaults.bool(forKey: "notificationState") as? Bool{
            switchOutlet.isOn = switchState
        }
    }
    
    
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBAction func notificationSwitchPressed(_ sender: Any) {
        
        
        defaults.set(switchOutlet.isOn, forKey: "notificationState")
        //        //MARK: - Create the notification

        print ("hello")
        if switchOutlet.isOn
        {
            print ("notification set to on")
            //TODO: - check if the taskList is empty
            
            
                let content = UNMutableNotificationContent()
                content.title = "You have tasks to complete!"
                content.subtitle = ""
                content.body = "Open the task manager to see which tasks need completion"
               // let alarmTime = Date().addingTimeInterval(5)
              //  let components = Calendar.current.dateComponents([.day, .month, .year], from: alarmTime)
              //  let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "taskReminder", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            } else {
            print ("notification set to off")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["taskReminder"])
        }


        
    }
    
    
    
    //MARK: - Model Manupulation Methods ( Saving"encoding" and Loading"decoding" data)
    
    
}
