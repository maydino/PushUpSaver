////
////  TimeManagement.swift
////  PushUpChallenge
////
////  Created by Mutlu Aydin on 2/28/22.
////
//
//import UIKit
//
//
//class TimeManagement {
//    
//    var timerMemoryManagement = MemoryManagement()
//    var dayLeft = 30
//    let now = Date.now.formatted()
//
//    func resetTheTime() {
//        
//    }
//    
//    // MARK: for dropping day down if push up left 0
//    func remainingDay() {
//        if timerMemoryManagement.defaults.object(forKey: "pushUp") as! Int == 0 {
//        dayLeft -= 1
//        timerMemoryManagement.defaults.set(dayLeft, forKey: "dayLeft")
//        }
//    }
//    
//    // MARK: 
//    func challengeStarted() {
//        
//        timerMemoryManagement.defaults.set(now, forKey: "challengeStartDate")
//        print("\(timerMemoryManagement.defaults.object(forKey: "challengeStartDate")!)")
//        
//        
//    }
//    
//    // MARK: Checking last day of use the app and today date difference
//    func challengeContinuityControl() {
//        
//        
//    }
//    
//
//}
