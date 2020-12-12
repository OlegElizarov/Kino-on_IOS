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
    
    lazy private var catalogController: CatalogViewController = {
        return CatalogViewController()
    }()
    
    lazy private var profileController: UIViewController = {
//        return ProfileViewController()
        return UINavigationController(rootViewController: ProfileViewController())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "KINO|ON"
        
        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        self.homeController.tabBarItem = homeTab
        
        let catalogTab = UITabBarItem(title: "Catalog", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        self.catalogController.tabBarItem = catalogTab
        
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        self.profileController.tabBarItem = profileTab
        
        viewControllers = [homeController, catalogController, profileController]
    }
}
