//
//  AppControl.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/28/22.
//

import UIKit
import UserNotifications

class AppControl {
    
    // MARK: - Alerts
    var showAlertChallengeTerminated = false
    var showAlertDailyPushUpCompleted = false
    var showAlertChallengeCompleted = false
    
    // MARK: - Variables
    var dayLeft: Int = 30
    var pushUpLeft: Int = 100
    var buttonPressed = false
    
    // MARK: - Dates
    let calendar = Calendar.current
    let dateManagement = DateManagement()
    
    // MARK: - Memory
    let userDefault = UserDefaultString()
        
    func startControl() {
        
        dayLeft = userDefault.dayLeftsUserDefaultsUnwrap()
        print(dayLeft)
        pushUpLeft = userDefault.pushUpsUserDefaultsUnwrap()
        print(pushUpLeft)
        
        if userDefault.challengeStartedUnwrap() {
            
            if dateManagement.todayDateFunc() == userDefault.todayUserDefaultsUnwrap() {
                
                forSameDayPushUpButtonPressedActions()
                
            } else if dateManagement.tomorrowDateFunc() == userDefault.tomorrowUserDefaultsUnwrap() && dayLeft > 0 {
                print("Next day")
                
                if pushUpLeft > 0 {
                    // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
                    
                    showAlertChallengeTerminated = true
                    
                    print("It's next day but you didn't complete all the push ups from yesterday")
                    
                    userDefault.removeUserDefaultsObjects()
                    
                } else {
                    print("Next day, challenge continue...")
                    userDefault.defaults.set(dateManagement.todayDateFunc(), forKey: userDefault.todayUserDefault)
                    userDefault.defaults.set(dateManagement.tomorrowDateFunc(), forKey: userDefault.tomorrowUserDefault)
                    
                    userDefault.defaults.set(100,forKey: userDefault.pushUpString)
                    dayLeft -= 1
                    userDefault.defaults.set(dayLeft, forKey: userDefault.dayLeftString)
                    startControl()
                }
                
            } else {
                // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
                showAlertChallengeTerminated = true
                
                userDefault.removeUserDefaultsObjects()
                
            }
        }
    }
    
    //MARK: - Save data to user defaults
    func setPushUpDefaultValue () {
        userDefault.defaults.setValue(pushUpLeft, forKey: userDefault.pushUpString)
    }
    
    func setDayLeftDefaultValue () {
        userDefault.defaults.setValue(dayLeft, forKey: userDefault.dayLeftString)
    }
    
    private func forSameDayPushUpButtonPressedActions () {
        if buttonPressed == true {
            buttonPressed = false
            
            if pushUpLeft > 0 && dayLeft > 0 {
                pushUpLeft -= 1
                setPushUpDefaultValue()
                setDayLeftDefaultValue()
            } else if pushUpLeft == 0 && dayLeft > 0 {
                
                // Remove all local notifications
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                // Daily push-up completed
                showAlertDailyPushUpCompleted = true

            } else if pushUpLeft == 0 && dayLeft == 0 {
                
                userDefault.removeUserDefaultsObjects()
                showAlertChallengeCompleted = true
                
            } else {
                print("something wrong at forSameDayPushUpButtonPressedActions")
            }
        } else {
            print("Challenge Started")
        }
    }
    
}



