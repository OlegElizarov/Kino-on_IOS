//
//  TabBarController.swift
//  KinoOnApp
//
//  Created by Konstantin Pronin on 06.11.2020.
//

import UIKit

class TabBarController: UITabBarController {
    lazy private var homeController: UIViewController = {
        return UINavigationController(rootViewController: HomeViewController())
    }()
    lazy private var profileController: UIViewController = {
        return UINavigationController(rootViewController: ProfileViewController())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        self.homeController.tabBarItem = homeTab
        
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        self.profileController.tabBarItem = profileTab
        
        viewControllers = [homeController, profileController]
    }
}
