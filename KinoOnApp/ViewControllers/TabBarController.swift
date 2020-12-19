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
    lazy var profileController: UIViewController = {
        let controller = ProfileViewController()
        controller.parentController = self
        let nav = UINavigationController(rootViewController: controller)
        nav.isNavigationBarHidden = true
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "KINO|ON"
        
        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        self.homeController.tabBarItem = homeTab
        
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        self.profileController.tabBarItem = profileTab
        
        viewControllers = [homeController, profileController]
    }
    
    func changeItemController(newController: UIViewController) {
        let nav = UINavigationController(rootViewController: newController)
        nav.isNavigationBarHidden = true
        profileController = nav
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        self.profileController.tabBarItem = profileTab
        
        viewControllers = [homeController, profileController]

    }
}
