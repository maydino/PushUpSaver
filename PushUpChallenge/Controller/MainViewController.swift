//
//  ViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/13/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let appControl = AppControl()
    
    // MARK: Remaining Day
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
        label.textColor = UIColor(named: "textColor")
        label.font = .boldSystemFont(ofSize: 50)
        return label
    }()
    
    let dayLeft : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        return label
    }()
    
    // MARK: Push Up Left Stack
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
        label.textColor = UIColor(named: "textColor")
        label.font = .boldSystemFont(ofSize: 50)
        return label
    }()
    
    let pushUpLeft : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        return label
    }()
    
    let startWorkoutButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Workout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        button.backgroundColor = .gray
        button.layer.cornerRadius  = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
                
        appControl.startControl()
        
        pushUpLeft.text = "\(appControl.pushUpLeft)"
        dayLeft.text = "\(appControl.dayLeft)"

        setUp()
    }
     
    func setUp() {
                
        dayStackView.addSubview(dayLeftLabel)
        dayStackView.addSubview(dayLeft)
        view.addSubview(dayStackView)
        
        pushUpStackView.addSubview(pushUpLeftLabel)
        pushUpStackView.addSubview(pushUpLeft)
        view.addSubview(pushUpStackView)
        
        view.addSubview(startWorkoutButton)

        NSLayoutConstraint.activate([
            // MARK: Days Left Stack View

            dayStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            dayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            dayStackView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8),
            dayStackView.heightAnchor.constraint(equalToConstant: 200),
            
            dayLeftLabel.centerXAnchor.constraint(equalTo: dayStackView.centerXAnchor, constant: 0),
            dayLeft.centerXAnchor.constraint(equalTo: dayStackView.centerXAnchor, constant: 0),
            dayLeft.topAnchor.constraint(equalTo: dayLeftLabel.bottomAnchor, constant: 10),
            
            // MARK: Push Up Stack View

            pushUpStackView.topAnchor.constraint(equalTo: dayStackView.bottomAnchor, constant: 50),
            pushUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pushUpStackView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8),
            pushUpStackView.heightAnchor.constraint(equalToConstant: 200),

            pushUpLeftLabel.centerXAnchor.constraint(equalTo: pushUpStackView.centerXAnchor, constant: 0),
            pushUpLeft.centerXAnchor.constraint(equalTo: pushUpStackView.centerXAnchor, constant: 0),
            pushUpLeft.topAnchor.constraint(equalTo: pushUpLeftLabel.bottomAnchor, constant: 10),
            
            startWorkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startWorkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            startWorkoutButton.widthAnchor.constraint(equalToConstant: view.bounds.width*0.7),
            startWorkoutButton.heightAnchor.constraint(equalToConstant: 70)
            
        ])
    }
    
    @objc func buttonTapped() {
        
        print("button pressed")
        let pushUpCountViewController = PushUpCountViewController()
        pushUpCountViewController.delegate = self
        pushUpCountViewController.modalPresentationStyle = .fullScreen
        self.present(pushUpCountViewController, animated:true, completion:nil)
        
        appControl.startControl()
        
        
        
    }

}

extension MainViewController: PushUpDelegate {
    func didPushUpTapped(count: Int) {
        pushUpLeft.text = "\(count)"
    }
    
}
