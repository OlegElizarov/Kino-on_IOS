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
    
    lazy private var catalogController: CatalogViewController = {
        return CatalogViewController()
    }()
    
    lazy var profileController: UIViewController = {
        let controller = ProfileViewController()
        controller.parentController = self
        let nav = UINavigationController(rootViewController: controller)
        nav.isNavigationBarHidden = true
        nav.modalTransitionStyle = .flipHorizontal
        return nav
    }()

    lazy var userController: UIViewController = {
        let controller = UserViewController()
        controller.parentController = self
        let nav = UINavigationController(rootViewController: controller)
        nav.isNavigationBarHidden = true
        nav.modalTransitionStyle = .flipHorizontal
        return nav
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        self.homeController.tabBarItem = homeTab
        
        let catalogTab = UITabBarItem(title: "Catalog", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        self.catalogController.tabBarItem = catalogTab
        
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)

        ProfileRepository().getUser {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success( _):
                    self.userController.tabBarItem = profileTab
                    self.viewControllers = [self.homeController, self.catalogController, self.userController]
                case .failure( _):
                    self.profileController.tabBarItem = profileTab
                    self.viewControllers = [self.homeController, self.catalogController, self.profileController]
                }
            }
        }
    }

    func changeItemController(newController: UIViewController) {
        let nav = UINavigationController(rootViewController: newController)
        nav.isNavigationBarHidden = true
        
        profileController = nav
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        self.profileController.tabBarItem = profileTab
        
        viewControllers = [homeController, catalogController, profileController]
    }
}
