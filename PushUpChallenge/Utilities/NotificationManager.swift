//
//  NotificationManager.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 10/14/22.
//  Copyright © 2022 Mutlu Aydin. All rights reserved.
//

import UIKit
import NotificationCenter

class NotificationManager {
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    private let savedDate: Date? = UserDefaultString.defaults.object(forKey: UserDefaultString.dailyReminderTime) as? Date

    //MARK: - Authorization Request From x
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if success {
                print("Success!!!")
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Send notification request to OS
    func sendNotification(hour: Int, minute: Int, idString: String) {
        
        // Content
        let content = UNMutableNotificationContent()
        content.title = "Hey!"
        content.body =  "You have push ups to do 💪"
        
        // Date Component
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
    
        // Trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Register the request
        let request = UNNotificationRequest(identifier: idString,
                                            content: content,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    
    }
    
    // Remove notification
    func removeNotification(idString: String) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [idString])
        userNotificationCenter.removeDeliveredNotifications(withIdentifiers: [idString])
    }
    
//    //MARK: - Local Notification
//    func localNotificationHandle(hour: Int, minute: Int, idString: String) {
//
//
//        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
//
//        if !isRegisteredForRemoteNotifications { // If user did not allowed the notification center before
//            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//            dailyReminderSwitch.isOn = false
//        }
//
//        // Notification Center
//        let center = UNUserNotificationCenter.current()
//
//        center.requestAuthorization(options: [.alert, .sound]) { [self]
//            (granted, error) in
//            if(!granted) {
//                print("Permission Denied")
//                DispatchQueue.main.async {
//                    self.dailyReminderSwitch.isOn = false
//
//                }
//            }
//        }
//        // Create the notification content
//        let content = UNMutableNotificationContent()
//        content.title = "Hey!"
//        content.body =  "You have push ups to do 💪"
//
//        // Create the notification trigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = hour
//        dateComponents.minute = minute
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        // Create the request
//        let request = UNNotificationRequest(identifier: idString, content: content, trigger: trigger)
//
//        // Register the request
//        if UserDefaultString.defaults.object(forKey: UserDefaultString.notification) != nil {
//            print("notification kaydetti")
//            center.add(request) { error in
//                if error != nil {
//                    print("oops, local notification error")
//                }
//            }
//        }
//    }
   
    
}




