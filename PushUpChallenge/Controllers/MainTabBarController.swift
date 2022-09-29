//
//  MainTabBarController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/27/22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .textColor
        UITabBar.appearance().unselectedItemTintColor = .systemBackground
        UITabBar.appearance().backgroundColor = .systemPink
                
        setViewControllers([createHomeNavigationController(),createStatsNavigationController(),createSettingsNavigationController()], animated: true)

    }
    
    func createHomeNavigationController() -> UINavigationController {
        let homeVC = MainViewController()
        homeVC.title = "Home"
        homeVC.tabBarItem.tag = 0
        homeVC.tabBarItem.image = UIImage(systemName: "play")!.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createStatsNavigationController() -> UINavigationController {
        let statsVC = StatsViewController()
        statsVC.title = "Stats"
        statsVC.tabBarItem.tag = 1
        statsVC.tabBarItem.image = UIImage(systemName: "chart.bar")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: statsVC)
    }
    
    func createSettingsNavigationController() -> UINavigationController {
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem.tag = 2
        settingsVC.tabBarItem.image = UIImage(systemName: "square.and.pencil")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: settingsVC)
    }
    
    


}

