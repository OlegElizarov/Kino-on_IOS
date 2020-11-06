//
//  TabBarController.swift
//  KinoOnApp
//
//  Created by Konstantin Pronin on 06.11.2020.
//

import UIKit

class TabBarController: UITabBarController {
    lazy private var homeController: HomeViewController = {
        return HomeViewController()
    }()
    lazy private var profileController: ProfileViewController = {
        return ProfileViewController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "KINO|ON"
        
        let homeTab = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        self.homeController.tabBarItem = homeTab
//        let homeTab = UITabBarItem(title: "Home", image: UIImage(named: "home_button"), tag: 0)
//        self.homeController.tabBarItem = homeTab
        
        let profileTab = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        self.profileController.tabBarItem = profileTab
        
        viewControllers = [homeController, profileController]
    }
}
