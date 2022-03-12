////
////  AppControl.swift
////  PushUpChallenge
////
////  Created by Mutlu Aydin on 2/28/22.
////
//
//import UIKit
//
//class AppControl {
//
//    // MARK: Alerts
//    let alert = Alert()
//    var showAlertChallengeTerminated = false
//    var showAlertDailyPushUpCompleted = false
//
//    var dayLeft = 30
//    var pushUpLeft = 100
//    var buttonPressed = false
//
//    var dayList = [Date]()
//
//    // MARK: Dates
//    let calendar = Calendar.current
//    var today = Date()
//    var difference = 0
//
//    // MARK: Memory
//    let defaults = UserDefaults.standard
//
//    func startControl() {
//
//        // First time user clicked start workout
//        if defaults.object(forKey: "pushUp") as? Int == nil && defaults.object(forKey: "dayLeft") as? Int == nil {
//
//            print("Step 0")
//            dayLeft = 30
//            pushUpLeft = 100
//            // Push Up
//            defaults.set(pushUpLeft, forKey: "pushUp")
//            // Day
//            defaults.set(dayLeft, forKey: "dayLeft")
//            // Last day user enter the app
//            defaults.set(today, forKey: "lastDayEnter")
//
//            for i in 0...29 {
//                dayList.append(today.addingTimeInterval(TimeInterval(i)*86400))
//                print(dayList)
//            }
//            defaults.set(dayList, forKey: "dayList")
//
//            // MARK: Alert Challenge started!
//            print("First time you open the challenge")
//
//        // After first time started app
//        } else if defaults.object(forKey: "pushUp") != nil && defaults.object(forKey: "dayLeft") != nil {
//
//            print("Step 1")
//
//            pushUpLeft = (defaults.object(forKey: "pushUp") as! Int)
//            dayLeft = (defaults.object(forKey: "dayLeft") as! Int)
//
//            // MARK: Step 1, Same Day, Still have push up to complete and day
//
//            if todayCheck() == true && tomorrowCheck() == false && defaults.object(forKey: "pushUp") as! Int > 0 && dayLeft >= 0 {
//
//                print("Step 2")
//
//
//                if (defaults.object(forKey: "pushUp") as! Int) == 100 && (defaults.object(forKey: "dayLeft") as! Int) == 30 {
//                    defaults.set(today, forKey: "lastDayEnter")
//                }
//
//                if buttonPressed == true {
//                    onePushUpCompleted()
//                    buttonPressed = false
//                }
//
//                defaults.set(pushUpLeft, forKey: "pushUp")
//                defaults.set(dayLeft, forKey: "dayLeft")
//
//                print("You Start to the challenge")
//
//            // MARK: Step 2, Same day All push Ups Completed
//            } else if todayCheck() == true && tomorrowCheck() == false && pushUpLeft == 0 && dayLeft >= 0 {
//                print("Step 3")
//
//                // MARK: Success! Daily 100 completed Alert! return to main view
//
//                showAlertDailyPushUpCompleted = true
//                print(today)
//
//            // MARK: New day, new push ups
//            } else if todayCheck() == false && tomorrowCheck() == true && pushUpLeft == 0 && dayLeft >= 0 {
//                print("Step 4")
//
//                // Push Up
//                pushUpLeft = 100
//                defaults.set(pushUpLeft, forKey: "pushUp")
//                // Day
//                defaults.object(forKey: "dayLeft")
//                dayLeft = dayLeft - 1
//                defaults.set(dayLeft, forKey: "dayLeft")
//                defaults.set(today, forKey: "lastDayEnter")
//
//            } else if todayCheck() == true || tomorrowCheck() == true && pushUpLeft == 0 && dayLeft == 0 {
//
//                print("Step 5")
//
//                // Push Up
//                defaults.set(100, forKey: "pushUp")
//                // Day
//                defaults.set(30, forKey: "dayLeft")
//
//                // MARK: Success! Daily 100 completed Alert! return to main view
//
//                print("Challenge Completed!")
//
//            } else if pushUpLeft > 0 && tomorrowCheck() == false && todayCheck() == false {
//                // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
//
//                print("Step 6")
//
//                // Push Up
//                defaults.set(100, forKey: "pushUp")
//                // Day
//                defaults.set(30, forKey: "dayLeft")
//
//                showAlertChallengeTerminated = true
//
//                print("User did not completed in the time")
//
//            } else if pushUpLeft == 0 && tomorrowCheck() == false && todayCheck() == false {
//                // MARK: Alert! Sorry, you didn't finish challenge in time, terminated the challenge, return the main view
//
//                print("Step 7")
//
//                // Push Up
//                defaults.set(100, forKey: "pushUp")
//                // Day
//                defaults.set(30, forKey: "dayLeft")
//
//                showAlertChallengeTerminated = true
//
//                defaults.set(today, forKey: "lastDayEnter")
//
//                print("User did not completed in the time")
//
//            }
//        }
//    }
//
//    private func onePushUpCompleted() {
//        pushUpLeft -= 1
//    }
//
//    func tomorrowCheck() -> Bool {
//
//        let start = (defaults.object(forKey: "lastDayEnter") as! Date).addingTimeInterval(86400)
//        let end = (defaults.object(forKey: "lastDayEnter") as! Date).addingTimeInterval(172800)
//        let range = start...end
//
//        if range.contains(today) {
//            print("tomorrow is tomorrow")
//            return true
//        } else {
//            return false
//        }
//
//    }
//
//    func todayCheck() -> Bool {
//        let todayCheck = calendar.isDateInToday(defaults.object(forKey: "lastDayEnter") as! Date)
//
//        print("Today is today\(calendar.isDateInToday(defaults.object(forKey: "lastDayEnter") as! Date))")
//
//        return todayCheck
//    }
//
//}
//
//extension Date {
//
//    static func - (recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?) {
//        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
//        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
//        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
//
//        return (month: month, day: day, hour: hour)
//    }
//}
//
//
