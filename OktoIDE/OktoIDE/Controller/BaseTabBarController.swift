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
        
        view.backgroundColor = .yellow
        viewControllers = [
            
            createNavController(vc: UIViewController(), title: "Home", tabImageName: "home"),
            createNavController(vc: UIViewController(), title: "Editor", tabImageName: "editor"),
            createNavController(vc: UIViewController(), title: "Profile", tabImageName: "avatar")
        ]
    }
    
    
    fileprivate func createNavController(vc: UIViewController, title: String, tabImageName: String) -> UIViewController {
        
        
        let navigationController = UINavigationController(rootViewController: vc)
        vc.view.backgroundColor = .white
        vc.navigationItem.title = title
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: tabImageName)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
