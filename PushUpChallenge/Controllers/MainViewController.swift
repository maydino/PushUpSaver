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
    let userDefault = UserDefaultString()
    private var pushUpTextFieldNumber : Int?

       
    // MARK: - Day Label Stack
    
    private let pushUpImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pushUp")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let enterCompletedLabel = PUCLabel()
    private let pushUpTextField = PUCTextField()
    private let saveButton = PUCButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        AppUtility.lockOrientation(.portrait)
        
        appControl.startControl()
        
        pushUpImageConfiguration()
        completedLabelConfiguration()

        pushUpTextFieldConfiguration()
        saveButtonConfiguration()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        appControl.startControl()

    }

    // MARK: - UI Configuration Functions
    
    // Push Up Image View Configuration
    func pushUpImageConfiguration() {
        view.addSubview(pushUpImage)
        pushUpImage.layer.cornerRadius = 10
        pushUpImage.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            pushUpImage.widthAnchor.constraint(equalToConstant: view.bounds.width*0.6),
            pushUpImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pushUpImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pushUpImage.heightAnchor.constraint(equalToConstant: view.bounds.width*0.6)
        ])
    }
    
    // Enter Completed Push Ups Label Configuration
    func completedLabelConfiguration() {
        enterCompletedLabel.translatesAutoresizingMaskIntoConstraints = false
        enterCompletedLabel.text = "Enter Completed Push Ups"
        enterCompletedLabel.textAlignment = .center
                
        view.addSubview(enterCompletedLabel)
        
        NSLayoutConstraint.activate([
            enterCompletedLabel.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8),
            enterCompletedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            enterCompletedLabel.topAnchor.constraint(equalTo: pushUpImage.bottomAnchor, constant: 20),
            enterCompletedLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    // Push Up Text Field Configuration
    func pushUpTextFieldConfiguration() {
        pushUpTextField.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(pushUpTextField)
        
        NSLayoutConstraint.activate([
            pushUpTextField.widthAnchor.constraint(equalToConstant: 100),
            pushUpTextField.topAnchor.constraint(equalTo: enterCompletedLabel.bottomAnchor, constant: 10),
            pushUpTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pushUpTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Save Completed Push Ups Button Configuration
    func saveButtonConfiguration() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .clear
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.setTitleColor(.systemGray, for: .highlighted)
        saveButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
                        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            saveButton.topAnchor.constraint(equalTo: pushUpTextField.bottomAnchor, constant: 15),
            saveButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    //MARK: - Button Actions
    // Save Button Pressed Action
    @objc func saveButtonPressed() {
        if let checkTheValue = Int(pushUpTextField.text!) {
            pushUpTextFieldNumber = checkTheValue
        } else if pushUpTextFieldNumber == 0 {
            print("You did not enter a number")
            pushUpTextFieldNumber = nil
        } else {
            print("You did not enter a number")
            pushUpTextFieldNumber = nil
        }
        print(pushUpTextFieldNumber)

        pushUpTextField.text = ""
    }
    
    
}

