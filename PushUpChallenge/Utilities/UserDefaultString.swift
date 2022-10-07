//
//  UserDefaultString.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 6/10/22.
//

import Foundation


struct UserDefaultString {
    
    static let reminderOnOff = "reminderOn" //Bool
    static let dailyReminderTime = "dailyReminderTime"
    static let notification = "notification"
    static let darkModeOn = "darkModeOn"

    
    static let dayLeftString = "dayLeft" // Will gone
    
    static let defaults = UserDefaults.standard
    let dateManagement = DateManagement()
    
    //MARK: - Clean all the user defaults data
    func removeUserDefaultsObjects() {
        
        UserDefaultString.defaults.removeObject(forKey: UserDefaultString.reminderOnOff)
        
        print("All User Defaults Objects Removed")
        
    }
    
    func dayLeftsUserDefaultsUnwrap () -> Int {
        if let dayLeftDefault = UserDefaultString.defaults.object(forKey: UserDefaultString.dayLeftString) as? Int {
            print("dayLeftsUserDefaultsUnwrap ran")
            return dayLeftDefault
        } else {
            return 30
        }
    }
    
}
