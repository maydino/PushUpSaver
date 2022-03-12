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

let customAlert = CustomAlert()

final class PushUpCountViewController: UIViewController {
    
    var delegate: PushUpDelegate!
    
    var appControl = AppControl()
    
    var alert = Alert()
    
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        button.setTitleColor(.textColor, for: .normal)
        button.addTarget(self, action: #selector(pushUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let infoLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        appControl.startControl()
        setUp()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if appControl.defaults.object(forKey: "firstTimeOpened") != nil {
            
            customAlert.showAlert(with: "Hello", message: "Touch the screen with your nose.", on: self)

        }

    }
    
    func setUp () {

        
        pushUpButton.setTitle("\(appControl.pushUpLeft)", for: .normal)
        
        view.addSubview(dismissButton)
        view.addSubview(pushUpButton)
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            
            dismissButton.widthAnchor.constraint(equalToConstant: 70),
            dismissButton.heightAnchor.constraint(equalToConstant: 70),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
           
            pushUpButton.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 0),
            pushUpButton.widthAnchor.constraint(equalToConstant: view.bounds.width),
            pushUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            infoLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            infoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)

        ])
        

    }
    
    @objc func pushUpButtonPressed() {
        
        appControl.buttonPressed = true
        infoLabel.text = ("\(appControl.info)")

        appControl.startControl()
        
        view.blink()


        if appControl.showAlertDailyPushUpCompleted == true {
            Alert.showAlert(on: self, titleText: "Congrats!", messageText: "You completed to today goal!")
            appControl.showAlertDailyPushUpCompleted = false

        } else if appControl.showAlertChallengeTerminated == true {
            Alert.showAlert(on: self, titleText: "Oops!", messageText: "You did a great job but the challenge didn't complete in time. You will start from day 1...")
            appControl.showAlertChallengeTerminated = false

        } else if appControl.showAlertChallengeCompleted == true {
            Alert.showAlert(on: self, titleText: "Wow!", messageText: """
            Congratulation!
            🎉🎉🎉
            You completed the challenge!
            """)
            appControl.showAlertChallengeTerminated = false
        }
        
        pushUpButton.setTitle("\(appControl.pushUpLeft)", for: .normal)

        print(appControl.pushUpLeft)
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
    
    
}

extension UIView{
    func blink() {
        self.backgroundColor = .white
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {self.backgroundColor = .backgroundColor}, completion: nil)
    }
}
