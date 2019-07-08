//
//  ProjectsPageViewController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import GithubAPI
import UIKit
import ViewAnimator

class ProjectsPageViewController: BaseUICollectionViewList, UISearchBarDelegate {

    private var projectSearchController = UISearchController(searchResultsController: nil)
    private var animationCounter = 0
    private  let animations = [AnimationType.from(direction: .right, offset: 30.0)]
    
    private var internetCheckerAlertView: CustomAlertView = {
        let view = CustomAlertView(title: "Unable To Connect", message: "Any changes you make will sync with Github when reconnected.")
        return view
    }()
    
    lazy private var appThemeSwitch: UISwitch = {
        
        var themeSwitch = UISwitch()
        
        themeSwitch.isOn = false
        themeSwitch.onTintColor = .green
        themeSwitch.addTarget(self, action: #selector(themeSwitchToggled(_:)), for: .valueChanged)
        themeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return themeSwitch
    }()
    
    var projects = [Project](){
        didSet{
            DispatchQueue.main.async { [weak self] in
                
                guard let self = self else {
                    return
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(appThemeSwitch)
        collectionView.register(ProjectsCollectionViewCell.self, forCellWithReuseIdentifier: ProjectsCollectionViewCell.id)
        setUpSearchBar()
        checkTheme()
        monitorInternetConnectivity()
        fecthRepositoriesFromGithub()
    }
    
    
    /// Animates the home page table view cells when app starts
    fileprivate func animateCells(){
        
        if (animationCounter <= 0) {
            collectionView.reloadData()
            collectionView.performBatchUpdates({
                UIView.animate(views: self.collectionView.orderedVisibleCells,
                               animations: animations, duration: 0.7, completion: {
                                self.animationCounter += 1
                })
            }, completion: nil)
        } else {
            return
        }
    }

    fileprivate func fecthRepositoriesFromGithub() {
        
        GithubService.shared.getUserProjects { (result) in
            
            switch result{
            case let .success(projects):
                self.projects = projects
                
                DispatchQueue.main.async { [weak self] in
                    
                    guard let self = self else { return }
                    self.animateCells()
                }
                
            case .failure(_):
                print("Error occured")
            }
        }
    }
    

    fileprivate func monitorInternetConnectivity() {
        
        NetworkReachabilityServices.shared.reachability.whenUnreachable = { reachability in
            if reachability.connection == .none || (reachability.connection != .wifi && reachability.connection != .cellular) {
                DispatchQueue.main.async {
                    self.internetCheckerAlertView.show(animated: true)
                }
            }
        }
        
        NetworkReachabilityServices.shared.reachability.whenReachable = { reachability in
            if reachability.connection == .wifi || reachability.connection == .cellular {
                DispatchQueue.main.async {
                    self.internetCheckerAlertView.dismiss(animated: true)
                    self.fecthRepositoriesFromGithub()
                }
            }
        }
    }
    
    fileprivate func checkTheme() {
        
        if ThemeService.shared.isThemeDark(){
            
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            collectionView.backgroundColor = .black
            UIApplication.shared.statusBarStyle = .lightContent
            projectSearchController.searchBar.setTextColor(color: .white)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.appThemeSwitch.isOn = true
            }
            
            
        } else {
            
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeService.shared.getMainColor()]
            navigationController?.navigationBar.barTintColor = .white
            collectionView.backgroundColor = .white
            UIApplication.shared.statusBarStyle = .default
            projectSearchController.searchBar.setTextColor(color: .black)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.appThemeSwitch.isOn = false
            }
        }
    }
    
    @objc fileprivate func themeSwitchToggled(_ sender: UISwitch){
        
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "isDarkMode")
            checkTheme()
        } else {
            UserDefaults.standard.set(false, forKey: "isDarkMode")
            checkTheme()
        }
    }
    
    /// Configures and Styles the search bar
    fileprivate func setUpSearchBar() {
        
        definesPresentationContext = true
        navigationItem.searchController = self.projectSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: appThemeSwitch)
        
        self.projectSearchController.dimsBackgroundDuringPresentation = false
        self.projectSearchController.searchBar.delegate = self
        
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            
            var fetchedResults = [Project]()
            
            projects.forEach { (project) in
                if project.name.contains(searchText) {
                    fetchedResults.append(project)
                }
            }
            
            self.projects = fetchedResults
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
