//
//  AppDelegate.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/25/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import CoreData
import IQKeyboardManager
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared().isEnabled = true
        window = UIWindow(frame: UIScreen.main.bounds)
        showHomePage(for: window)
        
        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        // Sync with Github SDK before the user goes offline
    }
    
    /**
     Displays the home page view controller on the given window
     - Parameters:
        - window : an instance of UIWindow to configure the root view controllers
     **/
    fileprivate func showHomePage(for window: UIWindow?){
        
        if let window = window {
            
            let destinationVC = BaseTabBarController()
            window.rootViewController = destinationVC
            window.makeKeyAndVisible()
        }
    }
}

