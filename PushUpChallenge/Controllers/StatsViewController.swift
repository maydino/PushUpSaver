//
//  PushUpCountViewController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 2/15/22.
//

import UIKit
import AVFoundation
import CoreData

final class StatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let userDefault = UserDefaultString()
    private let systemSoundID: SystemSoundID = 1306
    
    // TableView
    var tableView = UITableView()
    
    // Care Data Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var statsArray = [Stats]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: AppColors.backgroundColor)
        tableViewConfigure()
        
        AudioServicesPlaySystemSound(systemSoundID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()

        loadItems()
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        loadItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        loadItems()

    }
    
    func tableViewConfigure() {
        
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.reloadData()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let stat = statsArray[indexPath.row]
        
        cell.textLabel?.text = "Push Up: \(stat.pushUpDone!), Date: \(stat.date!)"
        cell.textLabel?.font = UIFont(name: AppFont.textFontNormal, size: 16)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor(named: AppColors.textColor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(statsArray[indexPath.row])
            statsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveItems()
        }
            
    }
    
    // Save Core Data Items
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error: \(error)")
        }
    }
    
    // Load Core Data Items
    func loadItems() {
        let request : NSFetchRequest<Stats> = Stats.fetchRequest()
        do {
            statsArray = try context.fetch(request)
            statsArray = statsArray.reversed()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
    
}


