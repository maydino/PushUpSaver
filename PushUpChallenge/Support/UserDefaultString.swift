//
//  UserDefaultString.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 6/10/22.
//

import Foundation


class UserDefaultString {
        
//    let lastDayEnter = "lastDayEnter"
    let pushUpString = "pushUp"
    let dayLeftString = "dayLeft"
    let firstTimeOpened = "firstTimeOpened"
    let challengeStarted = "challengeStarted"
    let todayUserDefault = "todayUserDefault"
    let tomorrowUserDefault = "tomorrowUserDefault"
    
    let defaults = UserDefaults.standard
//    let localTime = LocalTime()
    
    func challengeStartedUnwrap() -> Bool {
        
        if let challengeStarted = defaults.object(forKey: challengeStarted) as? Bool {
            return challengeStarted
        }
        return false
    }
    //MARK: - Clean all the user defaults data
    func removeUserDefaultsObjects() {
        
//        defaults.removeObject(forKey: lastDayEnter)
        defaults.removeObject(forKey: pushUpString)
        defaults.removeObject(forKey: dayLeftString)
        defaults.removeObject(forKey: firstTimeOpened)
        defaults.removeObject(forKey: challengeStarted)
        defaults.removeObject(forKey: todayUserDefault)
        defaults.removeObject(forKey: tomorrowUserDefault)


        print("All User Defaults Objects Removed")
    
    }
    
    func dayLeftsUserDefaultsUnwrap () -> Int {
        if let dayLeftDefault = defaults.object(forKey: dayLeftString) as? Int {
            print("dayLeftsUserDefaultsUnwrap ran")
            return dayLeftDefault
        } else {
            return 30
        }
    }
    
    func pushUpsUserDefaultsUnwrap () -> Int {
        if let pushUpsDefault = defaults.object(forKey: pushUpString) as? Int {
            print("pushUpsUserDefaultsUnwrap ran")
            return pushUpsDefault
        } else {
            return 100
        }
    }
    
    func todayUserDefaultsUnwrap () -> String {
        if let todayUserDefault = defaults.object(forKey: todayUserDefault) as? String {
            print("todayUserDefault ran")
            return todayUserDefault
        } else {
            return "empty"
        }
    }
    func tomorrowUserDefaultsUnwrap () -> String {
        if let tomorrowUserDefault = defaults.object(forKey: tomorrowUserDefault) as? String {
            print("tomorrowUserDefault ran")
            return tomorrowUserDefault
        } else {
            return "empty"
        }
    }
    
//    func lastDayEnterUnwrap() -> Date {
//        //Unwrap the lastDayEnter user default
//        print("lastDayEnterUnwrap ran")
//        if let lastDayEnterUnwrap = defaults.object(forKey: lastDayEnter) as? Date {
//            print("User default last day enter worked")
//            return lastDayEnterUnwrap
//        } else {
//            print("new local time")
//            return localTime.localTimeFunc()
//        }
//    }
}
