//
//  ViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/13/22.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController {
    
    let appControl = AppControl()
    let userDefault = UserDefaultString()
       
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
        label.font = UIFont(name: "Baskerville", size: 40)
        return label
    }()
    
    let dayLeft : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = UIFont(name: "Baskerville", size: 60)
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
        label.font = UIFont(name: "Baskerville", size: 40)
        return label
    }()
    
    let pushUpLeftCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = UIFont(name: "Baskerville", size: 60)
        return label
    }()
    
    let startWorkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Workout", for: .normal)
        button.titleLabel?.font = UIFont(name: "Baskerville", size: 30)
        button.setTitleColor(.backgroundColor, for: .normal)
        button.backgroundColor = .textColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startWorkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        AppUtility.lockOrientation(.portrait)
        
        appControl.startControl()

        pushUpLeftCountLabel.text = "\(appControl.pushUpLeft)"
        dayLeft.text = "\(appControl.dayLeft)"
        
        setUp()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appCameBackFromBackground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        appControl.startControl()

        pushUpLeftCountLabel.text = "\(appControl.pushUpLeft)"
        dayLeft.text = "\(appControl.dayLeft)"
    }

    
    @objc func startWorkoutButtonTapped() {
        print("Start workout button pressed")
        
        let pushUpCountViewController = PushUpCountViewController()
        pushUpCountViewController.delegate = self
        pushUpCountViewController.modalPresentationStyle = .fullScreen
        self.present(pushUpCountViewController, animated:true, completion:nil)
        
     }
    
    @objc func appCameBackFromBackground() {
        print("App Came Back From Background")
        appControl.startControl()

                
        pushUpLeftCountLabel.text = "\(appControl.pushUpLeft)"
        dayLeft.text = "\(appControl.dayLeft)"
        
    }
    
    //MARK: - View Constrains
    func setUp() {
        
        dayStackView.addSubview(dayLeftLabel)
        dayStackView.addSubview(dayLeft)
        view.addSubview(dayStackView)
        
        pushUpStackView.addSubview(pushUpLeftLabel)
        pushUpStackView.addSubview(pushUpLeftCountLabel)
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
            
            pushUpLeftCountLabel.centerXAnchor.constraint(equalTo: pushUpStackView.centerXAnchor, constant: 0),
            pushUpLeftCountLabel.topAnchor.constraint(equalTo: pushUpLeftLabel.bottomAnchor, constant: 10),
            
            startWorkoutButton.topAnchor.constraint(equalTo: pushUpStackView.bottomAnchor, constant: view.bounds.height*0.15),
            startWorkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            startWorkoutButton.widthAnchor.constraint(equalToConstant: view.bounds.width*0.7),
            startWorkoutButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1)
        ])
    }
}

//MARK: - Delegate Extension
extension MainViewController: PushUpDelegate {
    func didDayChange(count: Int) {
        dayLeft.text = "\(count)"
    }
    func didPushUpTapped(count: Int) {
        pushUpLeftCountLabel.text = "\(count)"
    }
}
