//
//  DateManager.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 6/13/22.
//  Copyright © 2022 Mutlu Aydin. All rights reserved.
//

import Foundation

struct DateManager {
    
    let today = Date()
    let tomorrow = Date().addingTimeInterval(86400)
    let dateFormatter = DateFormatter()
    
    func todayDateFunc () -> String {
        
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: today)
    }
    
    func tomorrowDateFunc () -> String {
        
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: tomorrow)
        
    }
    
}
