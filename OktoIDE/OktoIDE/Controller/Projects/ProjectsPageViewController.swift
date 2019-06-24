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

    fileprivate var projectSearchController = UISearchController(searchResultsController: nil)
    
    private var animationCounter = 0
    private  let animations = [AnimationType.from(direction: .right, offset: 30.0)]
    
    var projects = [Project](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fecthRepositories()
        setUpSearchBar()
        checkTheme()
        collectionView.register(ProjectsCollectionViewCell.self, forCellWithReuseIdentifier: ProjectsCollectionViewCell.id)
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
    
    fileprivate func fecthRepositories() {
        
        GithubService.shared.getUserProjects { (result) in
            
            switch result{
            case let .success(projects):
                self.projects = projects
                
                DispatchQueue.main.async {
                    self.animateCells()
                }
                
            case .failure(_):
                print("Error occured")
            }
        }
    }
    
    fileprivate func checkTheme() {
        
        if ThemeService.shared.isThemeDark(){
            collectionView.backgroundColor = .black
            
        } else {
            collectionView.backgroundColor = .white
        }
    }
    
    /// Configures and Styles the search bar
    fileprivate func setUpSearchBar() {
        
        definesPresentationContext = true
        navigationItem.searchController = self.projectSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
