//
//  AppControl.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/28/22.
//

import UIKit

class AppControl {
    
    // MARK: Alerts
    let alert = Alert()
    var showAlertChallengeTerminated = false
    var showAlertDailyPushUpCompleted = false
    var showAlertChallengeCompleted = false

    // Variables
    var dayLeft = 30
    var pushUpLeft = 100
    var buttonPressed = false
    
    // Constants
    let days = 30
    let pushUps = 100

    // MARK: Dates
    let calendar = Calendar.current
    let today = Date()
    var difference = 0
    
    // MARK: Memory
    let defaults = UserDefaults.standard
    
    // MARK: User Information
    var info = ""
    
    func startControl() {
        
        // First time user pressed start workout button
        if defaults.object(forKey: "pushUp") as? Int == nil || defaults.object(forKey: "dayLeft") as? Int == nil || defaults.object(forKey: "lastDayEnter") as? Date == nil {
            
            print("Step 0")
            // Push Up
            pushUpLeft = pushUps
            defaults.set(pushUps, forKey: "pushUp")
            // Day
            dayLeft = days
            defaults.set(dayLeft, forKey: "dayLeft")
            // Last day user enter the app
            defaults.set(today, forKey: "lastDayEnter")

            // MARK: Alert Challenge started!
            print("First time you open the challenge")
            
            info = "Challenge Started"

        // After first time started app
        } else if defaults.object(forKey: "pushUp") != nil && defaults.object(forKey: "dayLeft") != nil {
            
            print("Step 1")
                        
            pushUpLeft = (defaults.object(forKey: "pushUp") as! Int)
            dayLeft = (defaults.object(forKey: "dayLeft") as! Int)
            
                        
            // MARK: Step 1, Same Day, Still have push up to complete and day

            if todayCheck() == true && tomorrowCheck() == false && defaults.object(forKey: "pushUp") as! Int > 0 && dayLeft >= 0 {
                
                print("Step 2")

                if buttonPressed == true {
                    onePushUpCompleted()
                    buttonPressed = false
                    
                    if pushUpLeft == 0 && dayLeft > 0 {
                        showAlertDailyPushUpCompleted = true
                        info = "Challenge Completed for today..."
                    } else if pushUpLeft == 0 && dayLeft == 0 {
                        
                        print("Step 5")

                        removeUserDefaultsObjects()
                        showAlertChallengeCompleted = true
                    } else {
                        info = "Challenge Started"

                    }
                }
                
                defaults.set(pushUpLeft, forKey: "pushUp")
                defaults.set(dayLeft, forKey: "dayLeft")
                
                print("You Start to the challenge")
            
            // MARK: Step 2, Same day All push Ups Completed
            } else if todayCheck() == true && tomorrowCheck() == false && pushUpLeft == 0 && dayLeft >= 0 {
                print("Step 3")

                // MARK: Success! Daily 100 completed Alert! return to main view
                
                showAlertDailyPushUpCompleted = true
                print("All Push ups completed for today.")
                info = "Challenge Completed for today..."

            
            // MARK: New day, new push ups
            } else if todayCheck() == false && tomorrowCheck() == true && pushUpLeft == 0 && dayLeft >= 0 {
                print("Step 4")

                // Push Up
                pushUpLeft = pushUps
                defaults.set(pushUpLeft, forKey: "pushUp")
                // Day
                defaults.object(forKey: "dayLeft")
                dayLeft = dayLeft - 1
                defaults.set(dayLeft, forKey: "dayLeft")
                defaults.set(today, forKey: "lastDayEnter")

            } else if pushUpLeft > 0 && tomorrowCheck() == true {
                // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
                
                print("Step 6")

                removeUserDefaultsObjects()
                defaults.set(today, forKey: "lastDayEnter")

                
                showAlertChallengeTerminated = true
                
                print("User did not completed in the time")
                
            } else if pushUpLeft == 0 && tomorrowCheck() == false && todayCheck() == false {
                // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
                
                print("Step 7")

                removeUserDefaultsObjects()
                defaults.set(today, forKey: "lastDayEnter")

                showAlertChallengeTerminated = true
                
                print("User did not completed in the time")
                
            } else {
                removeUserDefaultsObjects()
                print("Something wrong")
            }
        } else {
            
            removeUserDefaultsObjects()
            print("Something happened")
            
        }
        
    }

    private func onePushUpCompleted() {
        pushUpLeft -= 1
    }
    
    func tomorrowCheck() -> Bool {
        
        let tomorrow = (defaults.object(forKey: "lastDayEnter") as! Date).addingTimeInterval(86400)
        
        if calendar.isDateInToday(tomorrow) {
            print("tomorrow is tomorrow")
            return true
        } else {
            return false
        }
    }
    
    func todayCheck() -> Bool {
        let todayCheck = calendar.isDateInToday(defaults.object(forKey: "lastDayEnter") as! Date)
        
        print("Today is today\(calendar.isDateInToday(defaults.object(forKey: "lastDayEnter") as! Date))")
        
        return todayCheck
    }
    
    func removeUserDefaultsObjects() {
        
        defaults.removeObject(forKey: "lastDayEnter")
        defaults.removeObject(forKey: "pushUp")
        defaults.removeObject(forKey: "dayLeft")
        defaults.removeObject(forKey: "firstTimeOpened")
        print("All User Defaults Objects Removed")
        
    }
    
}

