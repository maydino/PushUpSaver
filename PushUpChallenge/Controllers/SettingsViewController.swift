//
//  SettingsViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//

import UIKit

class SettingsViewController: UIViewController {

    let userDefault = UserDefaultString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown

    }
    

    //MARK: - Local Notification
    func localNotificationHandle(hour: Int, idString: String) {
        // Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
            if(!granted) {
                print("Permission Denied")
            }
        }
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "30 Days Push Up Challenge"
        content.body =  "You have push ups to complete"
        
        // Create the notification trigger
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: idString, content: content, trigger: trigger)
        
        // Register the request
        if userDefault.defaults.object(forKey: userDefault.pushUpString) != nil {
            center.add(request) { error in
                if error != nil {
                    print("oops, local notification error")
                }
            }
        }
    }


}
