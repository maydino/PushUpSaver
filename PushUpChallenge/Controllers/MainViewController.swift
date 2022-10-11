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
    
    let darkShadow = CALayer()
    let lightShadow = CALayer()
    let cornerRadius: CGFloat = 5
    let shadowRadius: CGFloat = 10
    
    private let todayDate = Date.now
    private var pushUpTextFieldNumber : Int?
    
    // Care Data Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var statsArray = [Stats]()

    // MARK: - View Properties
    private let pushUpImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pushUpImage")
        image.scalesLargeContentImage = true
        return image
    }()
    
    private let saveButton = PUCButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AppColors.backgroundColor)
        
        // Keep the screen portrait
        AppUtility.lockOrientation(.portrait)
                
        //MARK: - Configure Views
        pushUpImageConfiguration()
        saveButtonConfiguration()
        
        // See the file directory for Core Data
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }

    // MARK: - UI Configuration Functions
    
    // Push Up Image View Configuration
    func pushUpImageConfiguration() {
        pushUpImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pushUpImage)
        pushUpImage.layer.cornerRadius = 10
        pushUpImage.clipsToBounds = true
        pushUpImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            pushUpImage.widthAnchor.constraint(equalToConstant: view.bounds.width*0.9),
            pushUpImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pushUpImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pushUpImage.heightAnchor.constraint(equalToConstant: view.bounds.width*0.6)
        ])
    }
    

    // Save Completed Push Ups Button Configuration
    func saveButtonConfiguration() {
        
        saveButton.setTitle("Click and Enter Push Ups", for: .normal)
        saveButton.titleLabel?.font = UIFont(name: AppFont.textFontBold, size: 30)
        saveButton.titleLabel?.lineBreakMode = .byWordWrapping
        saveButton.titleLabel?.textAlignment = .center

        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 250),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            saveButton.topAnchor.constraint(equalTo: pushUpImage.bottomAnchor, constant: 60),
            saveButton.heightAnchor.constraint(equalToConstant: 100)
            
            
        ])
        
 
    }
    
    //MARK: - Button Actions
    // Save Button Pressed Action
    @objc func saveButtonPressed() {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Completed Push Ups", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Save", style: .default) { action in
            
            let newItem = Stats(context: self.context)
            newItem.date = self.todayDate.formatted(.dateTime)
            newItem.pushUpDone = textField.text ?? "0"
            
            self.statsArray.append(newItem)
            
            self.saveItems()
            print("Core Data saved")

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

