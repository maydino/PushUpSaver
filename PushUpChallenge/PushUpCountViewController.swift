//
//  PushUpCountViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/15/22.
//

import UIKit

protocol PushUpDelegate {
    func didPushUpTapped(count: Int)
}

class PushUpCountViewController: UIViewController {
    
    var delegate: PushUpDelegate!
    
    var pushUpLeft = MemoryManagement()
    
    let dismissButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        button.backgroundColor = .white
        button.setTitle("X", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        return button
    }()

    let pushUpButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        button.addTarget(self, action: #selector(pushUpButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        pushUpLeft.firstTime()

        setUp()
    }
    
    func setUp () {
        
        pushUpButton.setTitle("\(pushUpLeft.pushUpLeft)", for: .normal)
        
        view.addSubview(dismissButton)
        view.addSubview(pushUpButton)
        
        NSLayoutConstraint.activate([
            
            dismissButton.widthAnchor.constraint(equalToConstant: 70),
            dismissButton.heightAnchor.constraint(equalToConstant: 70),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            pushUpButton.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 0),
            pushUpButton.widthAnchor.constraint(equalToConstant: view.bounds.width),
            pushUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        ])
    }
    
    @objc func pushUpButtonPressed() {
        
        pushUpButton.setTitle("\(pushUpLeft.onePushUpCompleted())", for: .normal)
        
        pushUpLeft.defaults.set(pushUpLeft.pushUpLeft, forKey: "pushUp")

        print(pushUpLeft.pushUpLeft)
    }
    
    @objc func dismissButtonPressed() {
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            self.delegate.didPushUpTapped(count: self.pushUpLeft.pushUpLeft)
        })
        
        print("dismiss button pressed")
    }

}
