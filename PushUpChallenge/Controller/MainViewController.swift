//
//  ViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/13/22.
//

import UIKit
import UserNotifications

final class MainViewController: UIViewController {
    
    let appControl = AppControl()
       
    // MARK: - Day Label Stack
    let dayStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let dayLeftLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Days Left"
        label.textColor = .textColor
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
    let dayLeft : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        return label
    }()
    
    // MARK: - Push Up Left Label Stack
    let pushUpStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let pushUpLeftLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Push Up \n Left Today"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .textColor
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
    let pushUpLeft : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        return label
    }()
    
    let startWorkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Workout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.titleLabel?.textColor = .backgroundColor
        button.backgroundColor = .textColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startWorkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        pushUpLeft.text = "\(appControl.pushUpsUserDefaultsUnwrap())"
        dayLeft.text = "\(appControl.dayLeftsUserDefaultsUnwrap())"
        
        setUp()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appCameBackFromBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        localNotificationHandle(hour: 15)
        localNotificationHandle(hour: 17)
        localNotificationHandle(hour: 19)
        localNotificationHandle(hour: 21)
    }
    //MARK: - View Constrains
    func setUp() {
        
        dayStackView.addSubview(dayLeftLabel)
        dayStackView.addSubview(dayLeft)
        view.addSubview(dayStackView)
        
        pushUpStackView.addSubview(pushUpLeftLabel)
        pushUpStackView.addSubview(pushUpLeft)
        view.addSubview(pushUpStackView)
        
        view.addSubview(startWorkoutButton)
        
        NSLayoutConstraint.activate([
            dayStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.15),
            dayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            dayStackView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8),
            dayStackView.heightAnchor.constraint(equalToConstant: view.bounds.height*0.2),
            
            dayLeftLabel.centerXAnchor.constraint(equalTo: dayStackView.centerXAnchor, constant: 0),
            dayLeftLabel.topAnchor.constraint(equalTo: dayStackView.topAnchor, constant: 0),
            
            dayLeft.centerXAnchor.constraint(equalTo: dayStackView.centerXAnchor, constant: 0),
            dayLeft.topAnchor.constraint(equalTo: dayLeftLabel.bottomAnchor, constant: 10),
            
            pushUpStackView.topAnchor.constraint(equalTo: dayStackView.bottomAnchor, constant: view.bounds.height*0.1),
            pushUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pushUpStackView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8),
            pushUpStackView.heightAnchor.constraint(equalToConstant: view.bounds.height*0.2),
            
            pushUpLeftLabel.centerXAnchor.constraint(equalTo: pushUpStackView.centerXAnchor, constant: 0),
            pushUpLeftLabel.topAnchor.constraint(equalTo: pushUpStackView.topAnchor, constant: 0),
            
            pushUpLeft.centerXAnchor.constraint(equalTo: pushUpStackView.centerXAnchor, constant: 0),
            pushUpLeft.topAnchor.constraint(equalTo: pushUpLeftLabel.bottomAnchor, constant: 10),
            
            startWorkoutButton.topAnchor.constraint(equalTo: pushUpStackView.bottomAnchor, constant: view.bounds.height*0.15),
            startWorkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            startWorkoutButton.widthAnchor.constraint(equalToConstant: view.bounds.width*0.7),
            startWorkoutButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1)
        ])
    }
    
    @objc func startWorkoutButtonTapped() {
        print("Start workout button pressed")
        
        let pushUpCountViewController = PushUpCountViewController()
        pushUpCountViewController.delegate = self
        pushUpCountViewController.modalPresentationStyle = .fullScreen
        self.present(pushUpCountViewController, animated:true, completion:nil)
        appControl.defaults.set(true, forKey: "challengeStarted")
    }
    
    @objc func appCameBackFromBackground() {
        print("App Came Back From Background")
        
        pushUpLeft.text = "\(appControl.pushUpsUserDefaultsUnwrap())"
        dayLeft.text = "\(appControl.dayLeftsUserDefaultsUnwrap())"
    }
    
    //MARK: - Local Notification
    func localNotificationHandle(hour: Int) {
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
        content.title = "30 Days Push Up Challange"
        content.body =  "You have \(appControl.pushUpsUserDefaultsUnwrap()) to complete"
        // Create the notification trigger
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        // Register the request
        if appControl.defaults.object(forKey: "pushUp") != nil {
            center.add(request) { error in
                if error != nil {
                    print("oops, local notification error")
                }
            }
        }
    }
    
}

//MARK: - Delegate Extension
extension MainViewController: PushUpDelegate {
    func didDayChange(count: Int) {
        dayLeft.text = "\(count)"
    }
    func didPushUpTapped(count: Int) {
        pushUpLeft.text = "\(count)"
    }
}
