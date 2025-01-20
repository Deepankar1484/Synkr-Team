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
            let educationVC = viewControllers[1]
            educationVC.tabBarItem.title = "Time Capsule"
            educationVC.tabBarItem.image = UIImage(systemName: "battery.75percent")
//            educationVC.tabBarItem.selectedImage = UIImage(systemName: "envlpe.fill")
        }
    }
}
