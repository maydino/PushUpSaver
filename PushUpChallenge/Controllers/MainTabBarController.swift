//
//  MainTabBarController.swift
//  PushUpChallenge
//
//  Created by Mutlu Aydin on 9/27/22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    let attributes = [NSAttributedString.Key.font:UIFont(name: AppFont.textFontNormal, size: 18)]

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor(named: AppColors.textColorH)
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: AppColors.textColor)
        UITabBar.appearance().backgroundColor = UIColor(named: AppColors.buttonColor)
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)

                
        setViewControllers([createHomeNavigationController(),createStatsNavigationController(),createSettingsNavigationController()], animated: true)

    }
    
    func createHomeNavigationController() -> UINavigationController {
        let homeVC = MainViewController()
        homeVC.title = "Home".withOneSixthEmSpacing
        homeVC.tabBarItem.tag = 0
        homeVC.tabBarItem.image = UIImage(systemName: "play")!.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
    
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createStatsNavigationController() -> UINavigationController {
        let statsVC = StatsViewController()
        statsVC.title = "Stats".withOneSixthEmSpacing
        statsVC.tabBarItem.tag = 1
        statsVC.tabBarItem.image = UIImage(systemName: "chart.bar")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: statsVC)
    }
    
    func createSettingsNavigationController() -> UINavigationController {
        let settingsVC = SettingsViewController()
        settingsVC.title = "Remind me".withOneSixthEmSpacing
        settingsVC.tabBarItem.tag = 2
        settingsVC.tabBarItem.image = UIImage(systemName: "square.and.pencil")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2)
        return UINavigationController(rootViewController: settingsVC)
    }
    
    


}

extension String {
  var withOneSixthEmSpacing: String {
    let letters = Array(self)
    return letters.map { String($0) + "\u{2006}" }.joined()
  }
}
