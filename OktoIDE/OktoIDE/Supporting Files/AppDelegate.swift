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
        
        self.UserLoggeInState(window)
        //UIApplication.shared.statusBarStyle = .lightContent

        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        // Sync with Github SDK before the user goes offline
    }
    
    
    /// Redirectes user to Home page or login page based on Log in status
    fileprivate func UserLoggeInState(_ window: UIWindow?) {
        
        if UserDefaults.standard.value(forKey: "currentUser") != nil {
            self.showHomePage(for: window)
        } else {
            self.showOnboardingPage(for: window)
        }
    }
    
    /// Displays the home page view controller on the given window
    fileprivate func showHomePage(for window: UIWindow?){
        
        if let window = window {
            
            let destinationVC = ProjectsPageViewController()
            let navController = UINavigationController(rootViewController: destinationVC)
            destinationVC.navigationController?.navigationBar.prefersLargeTitles = true
            destinationVC.navigationItem.title = "Projects"
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
    
    /// Displays the onboarding page view controller on the given window
    func showOnboardingPage(for window: UIWindow?){
        
        if let window = window {
            
            let destinationVC = OnboardingViewController()
            window.rootViewController = destinationVC
            window.makeKeyAndVisible()
        }
    }
}

