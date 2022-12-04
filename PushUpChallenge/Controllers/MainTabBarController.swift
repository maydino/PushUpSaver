//
//  MainTabBarController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/27/22.
//  Copyright © 2022 Mutlu Aydin. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let attributes = [NSAttributedString.Key.font:UIFont(name: AppFont.textFontNormal, size: 20)]
    private let titleAttributes = [NSAttributedString.Key.font:UIFont(name: AppFont.textFontBold, size: 25)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor(named: AppColors.textColorH)
        UITabBar.appearance().selectedImageTintColor = UIColor(named: AppColors.textColor)
        UITabBar.appearance().backgroundColor = UIColor(named: AppColors.buttonColor)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        UITabBarItem.appearance().setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        additionalSafeAreaInsets.bottom = 10
        
        setViewControllers([createHomeNavigationController(),createStatsNavigationController(),createSettingsNavigationController()], animated: true)
    }
    
    // Home tab
    func createHomeNavigationController() -> UINavigationController {
        let homeVC = MainViewController()
        homeVC.title = "Home".withOneSixthEmSpacing
        homeVC.tabBarItem.tag = 0
        homeVC.tabBarItem.image = UIImage(systemName: "play")!.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: homeVC)
    }
    
    // Statistic tab
    func createStatsNavigationController() -> UINavigationController {
        let statsVC = StatsViewController()
        statsVC.title = "Stats".withOneSixthEmSpacing
        statsVC.tabBarItem.tag = 1
        statsVC.tabBarItem.image = UIImage(systemName: "chart.bar")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: statsVC)
    }
    
    // Settings tab
    func createSettingsNavigationController() -> UINavigationController {
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings".withOneSixthEmSpacing
        settingsVC.tabBarItem.tag = 2
        settingsVC.tabBarItem.image = UIImage(systemName: "square.and.pencil")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: settingsVC)
    }
}

extension String {
  var withOneSixthEmSpacing: String {
    let letters = Array(self)
    return letters.map { String($0) + "\u{2008}" }.joined()
  }
}
