//
//  Alert.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 3/1/22.
//

import Foundation
import UIKit


struct Alert {
    
    static var dismissVC = PushUpCountViewController()
    
    static func showAlert(on vc: UIViewController,titleText: String, messageText: String) {
        
        // create the alert
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        // add an action (button)
        
        vc.dismiss(animated: true, completion: nil)
       
        
        // show the alert
        vc.present(alert, animated: true)
        
    }
    
    
}
