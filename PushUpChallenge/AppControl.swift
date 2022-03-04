//
//  AppControl.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/28/22.
//

import UIKit

class AppControl {
    
//    let appControlMemoryManagement = MemoryManagement()
//    let appControlTimeManagement = TimeManagement()
    var dayLeft = 30
    var today = Date.now
    var lastDayEnter = Date()
    var pushUpLeft = 100

    let defaults = UserDefaults.standard
    
    func startControl() {
        print("Start Control ran")
        print("push up\(defaults.object(forKey: "pushUp"))")
        print("day left\(defaults.object(forKey: "dayLeft"))")


        // First time user clicked start workout
        if defaults.object(forKey: "pushUp") as? Int == nil || defaults.object(forKey: "dayLeft") as? Int == nil {
            
            // Push Up
            defaults.set(pushUpLeft, forKey: "pushUp")
            
            // Day
            defaults.set(dayLeft, forKey: "dayLeft")
            lastDayEnter = today
            
            // MARK: Alert Challenge started!
            
            print("First time you open the challenge")

        // Same day
        } else if defaults.object(forKey: "pushUp") != nil && defaults.object(forKey: "dayLeft") != nil {
            
            print("Something happened")

            if dayDifference() == 0 && defaults.object(forKey: "pushUp") as! Int > 0 {
                
                onePushUpCompleted()
                
                defaults.set(pushUpLeft, forKey: "pushUp")
                print("You Start to to challenge")
                
            } else if dayDifference() == 0 && pushUpLeft == 0 && dayLeft >= 0 {
                
                dayLeft -= 1
                
                // MARK: Success! Daily 100 completed Alert! return to main view
                print("100 push up completed for today")
                
            } else if dayDifference() == 0 && pushUpLeft == 0 && dayLeft == 0 {
                
                // Push Up
                defaults.set(100, forKey: "pushUp")
                
                // Day
                defaults.set(30, forKey: "dayLeft")
                
                // MARK: Success! Daily 100 completed Alert! return to main view
                
                print("Challenge Completed!")
                
            } else if pushUpLeft > 0 && pushUpLeft > 0 {
                // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
                
                // Push Up
                defaults.set(100, forKey: "pushUp")
                
                // Day
                defaults.set(30, forKey: "dayLeft")
                
                print("User did not completed in the time")
                
            }
        }
    }
    
    func dayDifference() -> Int? {
        let interval = today - lastDayEnter
        print("Day Difference: \(interval)")
        return interval.day
    }
    
    func onePushUpCompleted() {
        
        pushUpLeft -= 1
        
    }

    
    
}

extension Date {

    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        
        return (month: month, day: day, hour: hour)
    }
}


