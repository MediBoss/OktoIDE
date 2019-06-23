//
//  BaseTabBarController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            
            createNavController(vc: ProjectsPageViewController(), title: "Projects", tabImageName: "home"),
            createNavController(vc: ProfilePageController(), title: "Profile", tabImageName: "avatar")
        ]
    }
    
    /**
     Generates a navigation controller with given view controller.
     
     - Parameters:
         - vc: The view controller to be added on the navigation controller
         - title: The location's latitude coordinate
         - tabImageName: The name of the image file to be displayed at the bottom of tab bar

     - Returns: A navigation controller configured with given parameters
     **/
    fileprivate func createNavController(vc: UIViewController,
                                         title: String,
                                         tabImageName: String) -> UIViewController {
        
        
        
        let navigationController = UINavigationController(rootViewController: vc)
        
        if ThemeService.shared.isThemeDark(){
            navigationController.navigationBar.barTintColor = .black

            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
           navigationController.navigationBar.tintColor = .white
            tabBar.barTintColor = .black
            
        } else {
            
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeService.shared.getMainColor()]
            tabBar.unselectedItemTintColor = ThemeService.shared.getMainColor()
        }
        
        vc.navigationItem.title = title
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: tabImageName)

        return navigationController
    }
    
}
