//
//  PushUpCountViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/15/22.
//

import UIKit

protocol PushUpDelegate {
    func didPushUpTapped(count: Int)
    func didDayChange(count: Int)
    
}

class PushUpCountViewController: UIViewController {
    
    let customAlert = CustomAlert()
    let alert = Alert()
    
    var delegate: PushUpDelegate!
    
    let appControl = AppControl()
    let userDefault = UserDefaultString()
    let dateManagement = DateManagement()
    
    let dismissButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        button.setTitleColor(.textColor, for: .normal)
        button.setTitle("X", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let pushUpButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Baskerville", size: 100)
        button.setTitleColor(.textColor, for: .normal)
        button.addTarget(self, action: #selector(pushUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setUp()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        if userDefault.defaults.object(forKey: userDefault.firstTimeOpened) == nil {
            
            customAlert.showAlert(with: "Hello", message: "Touch the screen with your nose. You have 30 days to complete the challenge. Challenge started.", on: self)
            userDefault.defaults.set("Place Holder", forKey: userDefault.firstTimeOpened)
            
            //MARK: - Last day set is in here
            userDefault.defaults.set(dateManagement.todayDateFunc(), forKey: userDefault.todayUserDefault)
            print("local time set pushupVC")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if userDefault.defaults.object(forKey: userDefault.firstTimeOpened) == nil {
            
            //MARK: Custom Alert Shows
            customAlert.showAlert(with: "Hello", message: "Touch the screen with your nose. You have 30 days to complete the challenge. Challenge started.", on: self)
            //MARK: User default for understand the challenge started
            userDefault.defaults.set("Place Holder", forKey: userDefault.firstTimeOpened)
            
            //MARK: - User last open the app this date!
            userDefault.defaults.set(dateManagement.todayDateFunc(), forKey: userDefault.todayUserDefault)
            print("local time set pushupVC")
        }
        
        
    }
    
    func setUp () {
        
        pushUpButton.setTitle("\(userDefault.pushUpsUserDefaultsUnwrap())", for: .normal)
        
        view.addSubview(dismissButton)
        view.addSubview(pushUpButton)
        
        NSLayoutConstraint.activate([
            
            dismissButton.widthAnchor.constraint(equalToConstant: 70),
            dismissButton.heightAnchor.constraint(equalToConstant: 70),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            pushUpButton.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 0),
            pushUpButton.widthAnchor.constraint(equalToConstant: view.bounds.width),
            pushUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
    
    @objc func pushUpButtonPressed() {
        
        appControl.buttonPressed = true
        // Shows information about the challenge..
        
        userDefault.defaults.set(true, forKey: userDefault.challengeStarted)
        
        appControl.startControl()
        
        view.blink()
        
        pushUpButton.setTitle("\(userDefault.pushUpsUserDefaultsUnwrap())", for: .normal)
        
        print(userDefault.pushUpsUserDefaultsUnwrap())
        
        if userDefault.defaults.object(forKey: userDefault.todayUserDefault) == nil {
            userDefault.defaults.set(dateManagement.todayDateFunc(), forKey: userDefault.todayUserDefault)
        }
        
        //MARK: - ALERTS
        if appControl.showAlertDailyPushUpCompleted == true {
            Alert.showAlert(on: self, titleText: "Congrats!", messageText: "You completed to today goal!")
            appControl.showAlertDailyPushUpCompleted = false
            
        } else if appControl.showAlertChallengeTerminated == true {
            Alert.showAlert(on: self, titleText: "Oops!", messageText: "You did a great job, but the challenge didn't complete in time. Therefore, you will start from day 30...")
            appControl.showAlertChallengeTerminated = false
            
        } else if appControl.showAlertChallengeCompleted == true {
            Alert.showAlert(on: self, titleText: "Wow!", messageText: """
                Congratulation!
                🎉🎉🎉
                You completed the challenge!
                """)
            appControl.showAlertChallengeTerminated = false
        }
                
    }
    
    @objc func appMovedToBackground() {
        print("appMovedToBackground")
        
        if userDefault.defaults.object(forKey: userDefault.pushUpString) != nil {
            localNotificationHandle(hour: 15, idString: "PushUpOne")
            localNotificationHandle(hour: 16, idString: "PushUpTwo")
            localNotificationHandle(hour: 17, idString: "PushUpThird")
            localNotificationHandle(hour: 18, idString: "PushUpForth")
            localNotificationHandle(hour: 19, idString: "PushUpFive")
            localNotificationHandle(hour: 20, idString: "PushUpSix")
            localNotificationHandle(hour: 21, idString: "PushUpSeven")
            localNotificationHandle(hour: 22, idString: "PushUpEight")
        }
    }
    
    @objc func dismissButtonPressed() {
        
        dismissVCFunc()
        
        print("dismiss button pressed")
    }
    
    func dismissVCFunc() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            self.delegate.didPushUpTapped(count: self.appControl.pushUpLeft)
            self.delegate.didDayChange(count: self.appControl.dayLeft)
            
        })
    }
    
    //MARK: - Local Notification
    func localNotificationHandle(hour: Int, idString: String) {
        // Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
            if(!granted) {
                print("Permission Denied")
            }
        }
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "30 Days Push Up Challenge"
        content.body =  "You have push ups to complete"
        // Create the notification trigger
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        // Create the request
        
        let request = UNNotificationRequest(identifier: idString, content: content, trigger: trigger)
        // Register the request
        if userDefault.defaults.object(forKey: userDefault.pushUpString) != nil {
            center.add(request) { error in
                if error != nil {
                    print("oops, local notification error")
                }
            }
        }
    }
}

//MARK: - View blink
extension UIView{
    func blink() {
        self.backgroundColor = .white
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {self.backgroundColor = .backgroundColor}, completion: nil)
    }
}
