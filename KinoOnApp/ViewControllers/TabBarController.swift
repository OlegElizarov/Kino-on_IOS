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

    lazy private var catalogController: UIViewController = {
        return UINavigationController(rootViewController: CatalogViewController())
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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.05882352941, green: 0.2980392157, blue: 0.5058823529, alpha: 1)], for: .selected)
        UIBarButtonItem.appearance().tintColor = #colorLiteral(red: 0.05882352941, green: 0.2980392157, blue: 0.5058823529, alpha: 1)

        let homeTab = UITabBarItem(title: "Главная",
                image: UIImage(systemName: "house"), tag: 0)
        homeTab.selectedImage = UIImage(systemName: "house")?.withTintColor(#colorLiteral(red: 0.05882352941, green: 0.2980392157, blue: 0.5058823529, alpha: 1),
                renderingMode: .alwaysOriginal)
        self.homeController.tabBarItem = homeTab

        let catalogTab = UITabBarItem(title: "Каталог",
                image: UIImage(systemName: "magnifyingglass"), tag: 1)
        catalogTab.selectedImage = UIImage(systemName: "magnifyingglass")?.withTintColor(#colorLiteral(red: 0.05882352941, green: 0.2980392157, blue: 0.5058823529, alpha: 1),
                renderingMode: .alwaysOriginal)
        self.catalogController.tabBarItem = catalogTab

        let profileTab = UITabBarItem(title: "Профиль",
                image: UIImage(systemName: "person"), tag: 2)
        profileTab.selectedImage = UIImage(systemName: "person")?.withTintColor(#colorLiteral(red: 0.05882352941, green: 0.2980392157, blue: 0.5058823529, alpha: 1),
                renderingMode: .alwaysOriginal)
        ProfileRepository().getUser { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.userController.tabBarItem = profileTab
                    self.viewControllers = [self.homeController, self.catalogController, self.userController]
                case .failure(_):
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
        let profileTab = UITabBarItem(title: "Профиль",
                image: UIImage(systemName: "person"), tag: 2)
        profileTab.selectedImage = UIImage(systemName: "person")?.withTintColor(#colorLiteral(red: 0.05882352941, green: 0.2980392157, blue: 0.5058823529, alpha: 1),
                renderingMode: .alwaysOriginal)
        self.profileController.tabBarItem = profileTab

        viewControllers = [homeController, catalogController, profileController]
    }
}
