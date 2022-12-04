//
//  PUCAlert.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 3/1/22.
//  Copyright © 2022 Mutlu Aydin. All rights reserved.
//

import UIKit


class PUCAlertViewController: UIViewController {

    let containerView = UIView()
    let titleLabel = PUCTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = PUCBodyLabel(textAlignment: .center)
    let actionButton = PUCButton(backgroundColor: .systemGray)
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 10
    
    init (title: String, message: String, buttonTitle: String) {
        super .init(nibName: nil, bundle: nil)

        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemPink
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.systemGray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width/1.5),
            containerView.heightAnchor.constraint(equalToConstant: view.bounds.height/3)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Oppps! Try again."
        titleLabel.textColor = .systemGray
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureActionButton() {
        
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.setTitleColor(.systemGray, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 30),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureMessageLabel() {
        
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Opps! with body label"
        messageLabel.textColor = UIColor.systemGray
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -10),
        ])
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
  
}

