//
//  CustomAlert.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 3/9/22.
//

import Foundation
import UIKit

class CustomAlert {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let  backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    private var myTargetView: UIView?
    
    func showAlert (with title: String, message: String, on viewController: UIViewController) {
        
        guard let targetView = viewController.view else {
            return
        }
        
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        
        alertView.frame = CGRect(x: targetView.frame.width*0.1,
                                 y: targetView.frame.height*0.25,
                                 width: targetView.frame.size.width*0.8,
                                 height: targetView.frame.size.height*0.5)
                    
        let image = UIImageView(frame: CGRect(x: alertView.frame.width*0.1, y: alertView.frame.height*0.1, width: alertView.frame.width*0.8, height: alertView.frame.height*0.6))
        image.image = UIImage(named: "pushUp")
        image.contentMode = .scaleAspectFit
        alertView.addSubview(image)
        
        let messageLabel = UILabel(frame: CGRect(x: alertView.frame.size.width*0.05,
                                                 y: alertView.frame.height*0.77,
                                                 width: alertView.frame.size.width*0.9,
                                                 height: 30))
        messageLabel.numberOfLines = 2
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.text = message
        messageLabel.textColor = .textColor
        messageLabel.textAlignment = .center
        alertView.addSubview(messageLabel)
        
        let button = UIButton(frame: CGRect(x: 0, y: alertView.frame.size.height-50, width: alertView.frame.size.width, height: 50))
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self,
                         action: #selector(dismissAlert),
                         for: .touchUpInside)
        alertView.addSubview(button)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    @objc func dismissAlert () {
                
        guard let targetView = myTargetView else {
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.alertView.frame = CGRect(x: targetView.frame.width/2,
                                          y: targetView.frame.height,
                                     width: 0,
                                     height: 0)
            
        }, completion: { done in
            if done {
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                })
            }
        })
    }
}
