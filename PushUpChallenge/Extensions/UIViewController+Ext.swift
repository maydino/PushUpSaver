//
//  UIViewController+Ext.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//  Copyright © 2022 Mutlu Aydin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentPSSPAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            
            let alertVC = PUCAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
            
        }
        
    }
    
}
