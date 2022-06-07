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
    let alert = Alert()
    var showAlertChallengeTerminated = false
    var showAlertDailyPushUpCompleted = false
    var showAlertChallengeCompleted = false

    // MARK: - Variables
    var dayLeft = 30
    var pushUpLeft = 100
    var buttonPressed = false
    var challengeStarted = false
    
    // MARK: - Constants
    let days = 30
    let pushUps = 100

    // MARK: - Dates
    let calendar = Calendar.current
    let today = Date()
    var difference = 0
    
    // MARK: - Memory
    let defaults = UserDefaults.standard
    
    // MARK: - User Information
    var info = ""
    
    func startControl() {
        
        dayLeft = dayLeftsUserDefaultsUnwrap()
        pushUpLeft = pushUpsUserDefaultsUnwrap()
        
        if todayCheck() == true {
            
            forSameDayPushUpButtonPressedActions()                            
                
        } else if tomorrowCheck() == true {
            
            if pushUpLeft > 0 {
                // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
                
                print("It's next day but you didn't complete all the push ups from yesterday")

                removeUserDefaultsObjects()

                showAlertChallengeTerminated = true
                                
            } else {
                
                print("Next day, challenge continue...")

                defaults.set(today, forKey: "lastDayEnter")

                startControl()
            }
            
        } else {
            // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view

            removeUserDefaultsObjects()
            defaults.set(today, forKey: "lastDayEnter")

            showAlertChallengeTerminated = true
                        
        }
    }
    
    private func forSameDayPushUpButtonPressedActions () {
        
        if pushUpsUserDefaultsUnwrap() > 0 {
            
            if buttonPressed == true {
                onePushUpCompleted()
                buttonPressed = false
                
                if pushUpLeft == 0 && dayLeft > 0 {
                    showAlertDailyPushUpCompleted = true
                    info = "Challenge Completed for today..."
                } else if pushUpLeft == 0 && dayLeft == 0 {
                    
                    removeUserDefaultsObjects()
                    showAlertChallengeCompleted = true
                } else {
                    info = "Challenge Started"
                }
            }
        }
    }

    //MARK: - PushUp Counter
    private func onePushUpCompleted() {
        pushUpLeft -= 1
        setPushUpDefaultValue()
        setDayLeftDefaultValue()
    }
    
    //MARK: - Save data to user defaults
    
    func setPushUpDefaultValue () {
        defaults.setValue(pushUpLeft, forKey: "pushUp")
    }
    
    func setDayLeftDefaultValue () {
        defaults.setValue(dayLeft, forKey: "dayLEft")
    }
    
    //MARK: - Dates Control
    func tomorrowCheck() -> Bool {
        
        let tomorrow = lastDayEnterUnwrap().addingTimeInterval(86400)
        
        if calendar.isDateInToday(tomorrow) {
            print("tomorrow is tomorrow")
            return true
        } else {
            return false
        }
    }
    
    func todayCheck() -> Bool {
        
        if let lastDayEnterUser = defaults.object(forKey: "lastDayEnter") as? Date {
            let todayCheckBool = calendar.isDateInToday(lastDayEnterUser)
            print("Today is today \(todayCheckBool)")
            return(todayCheckBool)
        }
        return false
    }
    
    //MARK: - Unwrap the user defaults
    func lastDayEnterUnwrap () -> Date {
        if let lastDayEnter = defaults.object(forKey: "lastDayEnter") as? Date {
            return lastDayEnter
        } else {
            return today
        }
    }
    
    func pushUpsUserDefaultsUnwrap () -> Int {
        if let pushUpsDefault = defaults.object(forKey: "pushUp") as? Int {
            print("1111")
            return pushUpsDefault
        } else {
            return pushUps
        }
    }
    
    func dayLeftsUserDefaultsUnwrap () -> Int {
        if let dayLeftDefault = defaults.object(forKey: "dayLeft") as? Int {
            print("22222")
            return dayLeftDefault
        } else {
            return days
        }
    }
    
    //MARK: - Clean all the user defaults data
    func removeUserDefaultsObjects() {
        
        defaults.removeObject(forKey: "lastDayEnter")
        defaults.removeObject(forKey: "pushUp")
        defaults.removeObject(forKey: "dayLeft")
        defaults.removeObject(forKey: "firstTimeOpened")
        print("All User Defaults Objects Removed")
    
    }
    
}


     
