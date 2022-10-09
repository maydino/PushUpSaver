//
//  SettingsViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//

import UIKit

class SettingsViewController: UIViewController {
        
    // Reminder on and off row, First Row
    let darkModeOnLabel = PUCLabel(textAlignment: .left, fontSize: 20, title: "Dark mode")
    let darkModeOnSwitch = UISwitch()
    
    // Reminder on and off row, Second Row
    let dailyReminderOnOffLabel = PUCLabel(textAlignment: .left, fontSize: 20, title: "Daily Reminder On-Off")
    let dailyReminderSwitch = UISwitch()
    
    // Time Picker Info, Third Row
    let timePickTextLabel = PUCLabel(textAlignment: .left, fontSize: 20, title: "Pick the daily reminder time")
    let timePickTextField = PUCTextField()
    
    // Time Picker, Bottom Row
    let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    // User Default
    let darkModeOnSwitchDefault = UserDefaultString.defaults.object(forKey: UserDefaultString.darkModeOn) as? Bool ?? false
    let onOffSwitch = UserDefaultString.defaults.object(forKey: UserDefaultString.reminderOnOff) as? Bool ?? false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Backgroundcolor
        view.backgroundColor = UIColor(named: AppColors.backgroundColor)
        
        // First Row
        darkModeOnLabelConfiguration()
        darkModeOnSwitchConfiguration()
        
        // Second Row
        dailyReminderOnOffLabelConfiguration()
        dailyReminderSwitchConfiguration()
        
        // Third Row
        TimePickTextLabelConfiguration()
        timePickTextFieldConfiguration()
        
        // Bottom Row
        timePickerConfiguration()
        
    }
    
    //MARK: - First Row UI Configuration
    
    func darkModeOnLabelConfiguration() {
        
        view.addSubview(darkModeOnLabel)
        
        NSLayoutConstraint.activate([
        
            darkModeOnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            darkModeOnLabel.heightAnchor.constraint(equalToConstant: 50),
            darkModeOnLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            darkModeOnLabel.widthAnchor.constraint(equalToConstant: 240)

        ])
    }
    
    func darkModeOnSwitchConfiguration() {
        if darkModeOnSwitchDefault == true {
            darkModeOnSwitch.isOn = true
        }
        
        darkModeOnSwitch.addTarget(self, action: #selector(darkModeSwitchValueDidChange(_:)), for: .allTouchEvents)
        darkModeOnSwitch.frame = CGRect(x: view.bounds.width-65, y: 100, width: 100, height: 50)
        view.addSubview(darkModeOnSwitch)
        
    }
    
    @objc func darkModeSwitchValueDidChange(_ sender: UISwitch) {

        
        if #available(iOS 13.0, *) {
             let appDelegate = UIApplication.shared.windows.first
                 if sender.isOn {
                     UserDefaultString.defaults.set(true, forKey: UserDefaultString.darkModeOn)
                    appDelegate?.overrideUserInterfaceStyle = .dark
                      return
                 } else {
                     UserDefaultString.defaults.set(false, forKey: UserDefaultString.darkModeOn)
                 }
             appDelegate?.overrideUserInterfaceStyle = .light
             return
        }

    }
    
    //MARK: - Second Row UI Configuration
    
    func dailyReminderOnOffLabelConfiguration() {
        
        view.addSubview(dailyReminderOnOffLabel)
        
        NSLayoutConstraint.activate([
        
            dailyReminderOnOffLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            dailyReminderOnOffLabel.heightAnchor.constraint(equalToConstant: 50),
            dailyReminderOnOffLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dailyReminderOnOffLabel.widthAnchor.constraint(equalToConstant: 240)

        ])
    }
    
    func dailyReminderSwitchConfiguration() {
        if onOffSwitch == true {
            dailyReminderSwitch.isOn = true
        }
        
        dailyReminderSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .allTouchEvents)
        dailyReminderSwitch.frame = CGRect(x: view.bounds.width-65, y: 150, width: 100, height: 50)
        view.addSubview(dailyReminderSwitch)
        
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch) {
        let reminderHour = Int(timePicker.date.getFormattedDate(format: "HH")) ?? 0
        let reminderMinute = Int(timePicker.date.getFormattedDate(format: "mm")) ?? 0
        
        if dailyReminderSwitch.isOn == true {
            print("turned on")
            UserDefaultString.defaults.set(true, forKey: UserDefaultString.reminderOnOff)
            localNotificationHandle(hour: reminderHour, minute: reminderMinute, idString: "Time to do some push-ups!")

        } else {
            print("turned Off")
            UserDefaultString.defaults.set(false, forKey: UserDefaultString.reminderOnOff)
            UserDefaultString.defaults.set(nil, forKey: UserDefaultString.notification)

        }

        print(reminderHour, reminderMinute)
    }
    
    //MARK: - Third Row UI Configuration

    func TimePickTextLabelConfiguration() {

        view.addSubview(timePickTextLabel)
        
        NSLayoutConstraint.activate([
        
            timePickTextLabel.topAnchor.constraint(equalTo: dailyReminderOnOffLabel.bottomAnchor, constant: 20),
            timePickTextLabel.heightAnchor.constraint(equalToConstant: 40),
            timePickTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timePickTextLabel.widthAnchor.constraint(equalToConstant: 240)

        ])
    }
    
    func timePickTextFieldConfiguration() {
        timePickTextField.placeholder = "Tap it"
        
        if let savedDate = UserDefaultString.defaults.object(forKey: UserDefaultString.dailyReminderTime) {
            timePickTextField.text = (savedDate as! Date).getFormattedDate(format: "hh:mm a")
            print(savedDate as! Date)
        }
        
        timePickTextField.textAlignment = .center
        timePickTextField.backgroundColor = .systemGray4
        timePickTextField.layer.borderWidth = 3.0
        timePickTextField.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(timePickTextField)
        
        NSLayoutConstraint.activate([
        
            timePickTextField.topAnchor.constraint(equalTo: timePickTextLabel.topAnchor, constant: 0),
            timePickTextField.heightAnchor.constraint(equalToConstant: 40),
            timePickTextField.leadingAnchor.constraint(equalTo: timePickTextLabel.trailingAnchor, constant: 10),
            timePickTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            
        ])
                
    }
    
    //MARK: - Time Picker Bottom Row
    // Configuration
    func timePickerConfiguration() {
        
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Toolbar Button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDonePressed))
        toolbar.setItems([doneButton], animated: true)
        
        // Assign toolbar
        timePickTextField.inputAccessoryView = toolbar
        
        // Assign date picker to the textField
        timePickTextField.inputView = timePicker
        
    }
    
    // Action
    @objc func timePickerDonePressed() {
                
        timePickTextField.text = timePicker.date.getFormattedDate(format: "hh:mm a")
        UserDefaultString.defaults.set(timePicker.date, forKey: UserDefaultString.dailyReminderTime)
        
        self.view.endEditing(true)
        
    }

    
    //MARK: - Local Notification
    func localNotificationHandle(hour: Int, minute: Int, idString: String) {
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
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: idString, content: content, trigger: trigger)
        
        // Register the request
        if UserDefaultString.defaults.object(forKey: UserDefaultString.notification) != nil {
            center.add(request) { error in
                if error != nil {
                    print("oops, local notification error")
                }
            }
        }
    }

}
