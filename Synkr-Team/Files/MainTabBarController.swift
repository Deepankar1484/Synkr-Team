//
//  MainTabBarController.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 20/01/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewControllers = self.viewControllers {
            let homeVC = viewControllers[0]
            homeVC.tabBarItem.title = "My tasks"
            homeVC.tabBarItem.image = UIImage(systemName: "house")
            
            let timeVC = viewControllers[1]
            timeVC.tabBarItem.title = "Time Capsule"
            timeVC.tabBarItem.image = UIImage(systemName: "battery.75percent")
            
            
            let awardsVC = viewControllers[2]
            awardsVC.tabBarItem.title = "Awards"
            awardsVC.tabBarItem.image = UIImage(systemName: "trophy")
        }
    }
}
