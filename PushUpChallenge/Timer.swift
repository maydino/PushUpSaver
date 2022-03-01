//
//  Timer.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/28/22.
//

import UIKit


class TimerDay {
    
    var timerMemoryManagement = MemoryManagement()
        
    func resetTheTime() {
        
    }
    
    func challengeStarted() {
        
        let now = Date.now
        timerMemoryManagement.defaults.set(now, forKey: "challengeStartDate")
        print("\(timerMemoryManagement.defaults.object(forKey: "challengeStartDate")!)")
        
        
    }
    

}
