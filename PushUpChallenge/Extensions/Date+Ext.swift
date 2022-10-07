//
//  Date+Ext.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 10/5/22.
//

import Foundation


extension Date {
   func getFormattedDate(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
