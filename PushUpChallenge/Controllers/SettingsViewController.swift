//
//  SettingsViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/28/22.
//

import UIKit
import UserNotifications

final class SettingsViewController: UIViewController {
    
    // Notification
    private let notificationManager = NotificationManager()
    
    //MARK: - UI Properties
    // Reminder on and off row, First Row
    private let darkModeOnLabel = PUCLabel(textAlignment: .left, textFontName: AppFont.textFontNormal, fontSize: 20, title: "Dark mode")
    private let darkModeOnSwitch = UISwitch()
    
    // Reminder on and off row, Second Row
    private let dailyReminderOnOffLabel = PUCLabel(textAlignment: .left, textFontName: AppFont.textFontNormal, fontSize: 20, title: "Daily Reminder On-Off")
    private let dailyReminderSwitch = UISwitch()
    
    // Time Picker Info, Third Row
    private let timePickTextLabel = PUCLabel(textAlignment: .left, textFontName: AppFont.textFontNormal, fontSize: 20, title: "Set reminder time")
    private let timePickTextField = PUCTextField()
    
    // Time Picker, Bottom Row
    private let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    //MARK: - Unwrap User Default Properties
    private let darkModeOnSwitchDefault: Bool? = UserDefaultString.defaults.object(forKey: UserDefaultString.darkModeOn) as? Bool
    private let reminderOnOffBool: Bool? = UserDefaultString.defaults.object(forKey: UserDefaultString.reminderOnOff) as? Bool
    private let savedDate: Date? = UserDefaultString.defaults.object(forKey: UserDefaultString.dailyReminderTime) as? Date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationManager.requestNotificationAuthorization()
        
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
    
    //MARK: - First Row UI, FOR DARK MODE
    
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
    
    //MARK: - Second Row, FOR DAILY REMINDER
    func dailyReminderOnOffLabelConfiguration() {
        
        view.addSubview(dailyReminderOnOffLabel)
        
        NSLayoutConstraint.activate([
            dailyReminderOnOffLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            dailyReminderOnOffLabel.heightAnchor.constraint(equalToConstant: 50),
            dailyReminderOnOffLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dailyReminderOnOffLabel.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func dailyReminderSwitchConfiguration() {
        if reminderOnOffBool == true { dailyReminderSwitch.isOn = true }
        
        dailyReminderSwitch.addTarget(self, action: #selector(dailyReminderSwitchChanged(_:)), for: .allTouchEvents)
        dailyReminderSwitch.frame = CGRect(x: view.bounds.width-65, y: 150, width: 100, height: 50)
        view.addSubview(dailyReminderSwitch)
    }
    
    @objc func dailyReminderSwitchChanged(_ sender: UISwitch) {
        
        if dailyReminderSwitch.isOn == false {
            UserDefaultString.defaults.set(false, forKey: UserDefaultString.reminderOnOff)
            notificationManager.removeNotification(idString: "reminder")
            print("notification turned off")
            return
        }
        
        // Check notification status and return 
        notificationManager.userNotificationCenter.getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus  {
            case .authorized:
                print("User granted permission for notification")
                
                DispatchQueue.main.async { [self] in
                    
                    if self.timePickTextField.text != "" {
                        // Set Daily reminder on
                        dailyReminderSwitch.isOn = true
                        UserDefaultString.defaults.set(true, forKey: UserDefaultString.reminderOnOff)
                        
                        // Save the time and set the notification
                        notificationManager.sendNotification(hour: datePickerComponent().hour!, minute: datePickerComponent().minute!, idString: "reminder")
                        
                    } else {
                        //Show an alert if the time hasn't been chosen.
                        let noSavedDateAlert = UIAlertController(title: "Alert", message: "Please Pick a time first", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                        noSavedDateAlert.addAction(alertAction)
                        UserDefaultString.defaults.set(nil, forKey: UserDefaultString.reminderOnOff)
                        present(noSavedDateAlert, animated: true)
                        dailyReminderSwitch.isOn = false
                    }
                }
            // If user deny notifications
            case .denied:
                print("User denied notification permission")
                DispatchQueue.main.async {
                    self.dailyReminderSwitch.isOn = false
                }
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                
            case .notDetermined:
                print("Notification permission haven't been asked yet")
                self.dailyReminderSwitch.isOn = false
            case .provisional:
                // @available(iOS 12.0, *)
                print("The application is authorized to post non-interruptive user notifications.")
            case .ephemeral:
                // @available(iOS 14.0, *)
                print("The application is temporarily authorized to post notifications. Only available to app clips.")
            @unknown default:
                print("Unknown Status")
            }
        })
    }
    
    //MARK: - Third Row, SET THE TIME
    func TimePickTextLabelConfiguration() {
        
        view.addSubview(timePickTextLabel)
        
        NSLayoutConstraint.activate([
            timePickTextLabel.topAnchor.constraint(equalTo: dailyReminderOnOffLabel.bottomAnchor, constant: 10),
            timePickTextLabel.heightAnchor.constraint(equalToConstant: 40),
            timePickTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timePickTextLabel.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func timePickTextFieldConfiguration() {
        timePickTextField.placeholder = "Tap it"
        
        if let date = savedDate {
            timePickTextField.text = date.getFormattedDate(format: "hh:mm a")
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
    
    //MARK: - Bottom Row, TIME PICKER
    // Configuration
    func timePickerConfiguration() {
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Toolbar Button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDonePressed))
        let dismissButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil);
        toolbar.setItems([doneButton, flexibleSpace, dismissButton], animated: true)
        // Assign toolbar
        timePickTextField.inputAccessoryView = toolbar
        
        // Assign date picker to the textField
        timePickTextField.inputView = timePicker
    }
    
    // Action
    @objc func timePickerDonePressed() {
        
        timePickTextField.text = timePicker.date.getFormattedDate(format: "hh:mm a")
        UserDefaultString.defaults.set(timePicker.date, forKey: UserDefaultString.dailyReminderTime)
        
        // Set the notification
        if dailyReminderSwitch.isOn {
            notificationManager.sendNotification(hour: datePickerComponent().hour!, minute: datePickerComponent().minute!, idString: "reminder")
            print(2)
        }
        
        self.view.endEditing(true)
    }
    
    @objc func cancelPressed() {
        self.view.endEditing(true)
    }
    
    
    
    func datePickerComponent() -> DateComponents {
        let date = timePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        return components
    }
}
