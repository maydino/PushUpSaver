//
//  DateManagement.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 6/13/22.
//

import Foundation

struct DateManagement {
    
    let today = Date()
    let tomorrow = Date().addingTimeInterval(86400)
    let dateFormatter = DateFormatter()
    
    func todayDateFunc () -> String {
        
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MM-dd-yyyy"
        print(dateFormatter.string(from: today))
        return dateFormatter.string(from: today)
    }
    
    func tomorrowDateFunc () -> String {
        
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MM-dd-yyyy"
        print(dateFormatter.string(from: tomorrow))
        return dateFormatter.string(from: tomorrow)
    }
    
}
