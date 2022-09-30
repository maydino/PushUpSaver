//
//  PushUpCountViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/15/22.
//

import UIKit
import AVFoundation

final class StatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userDefault = UserDefaultString()
    let systemSoundID: SystemSoundID = 1306
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        tableViewConfigure()

        
        AudioServicesPlaySystemSound(systemSoundID)
        
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    func tableViewConfigure() {
        
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = "test"
        cell.backgroundColor = .clear
        return cell
    }
    
    
}


