//
//  ViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/13/22.
//

import UIKit
import UserNotifications
import CoreData

final class MainViewController: UIViewController {
    
    // MARK: - These will go
    lazy var userDefault = UserDefaultString()
    lazy var appControl = AppControl()

    
    let todayDate = Date.now
    private var pushUpTextFieldNumber : Int?
    
    // Care Data Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var statsArray = [Stats]()

    // MARK: - View Properties
    private let pushUpImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pushUpImage")
        image.scalesLargeContentImage = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let enterCompletedLabel = PUCLabel()
    private let saveButton = PUCButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        // Keep the screen portrait
        AppUtility.lockOrientation(.portrait)
        
        // Probably we wont need this function
        appControl.startControl()
        
        //MARK: - Configure Views
        pushUpImageConfiguration()
        completedLabelConfiguration()
        saveButtonConfiguration()
        
        // See the file directory
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        pushUpImage.contentMode = .scaleAspectFit
        

        NSLayoutConstraint.activate([
            pushUpImage.widthAnchor.constraint(equalToConstant: view.bounds.width*0.9),
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
    
    // Save Completed Push Ups Button Configuration
    func saveButtonConfiguration() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Click and Enter Push Ups", for: .normal)
        saveButton.backgroundColor = .systemTeal
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.setTitleColor(.systemGray, for: .highlighted)
        saveButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
                        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 250),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            saveButton.topAnchor.constraint(equalTo: pushUpImage.bottomAnchor, constant: 60),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    //MARK: - Button Actions
    // Save Button Pressed Action
    @objc func saveButtonPressed() {
        
        var textField = UITextField()
        textField.frame.size.width = 25
        
        
        let alert = UIAlertController(title: "Add Completed Push Ups", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Save", style: .default) { action in
            
            let newItem = Stats(context: self.context)
            newItem.date = self.todayDate.formatted(.dateTime)
            newItem.pushUpDone = textField.text ?? "0"
            
            print(newItem.pushUpDone)
            print(newItem.date)
            
            self.statsArray.append(newItem)
            
            print("we saved")
            self.saveItems()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter push ups..."
            textField = alertTextField
            textField.keyboardType = .asciiCapableNumberPad

        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        
        present(alert, animated: false)
        
        if let checkTheValue = Int(textField.text!) {
            pushUpTextFieldNumber = checkTheValue
        } else if pushUpTextFieldNumber == 0 {
            print("You did not enter a number")
            pushUpTextFieldNumber = nil
        } else {
            print("You did not enter a number")
            pushUpTextFieldNumber = nil
        }
        print(pushUpTextFieldNumber)

        textField.text = ""
    }
    
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error: \(error)")
        }
        
    }    
    
}

