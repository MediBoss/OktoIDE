//
//  ProjectDetailsViewController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/21/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


class ProjectDetailsViewController: UIViewController {
    
    let projectContentTableView: UITableView = {
        
        let tableview = UITableView()

        return tableview
    }()
    
    var project: Project!
    
    var contents = [Content](){
        didSet{
            DispatchQueue.main.async {
                self.projectContentTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        projectContentTableView.reloadData()
        view.addSubview(projectContentTableView)
        projectContentTableView.fillSuperview()
        
        projectContentTableView.delegate = self as UITableViewDelegate
        projectContentTableView.dataSource = self as UITableViewDataSource
        
        setUpNavBar()
        checkTheme()
        
        projectContentTableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.id)
    }
    
    fileprivate func setUpNavBar() {
        
        navigationItem.title = "\(project.name)"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(NewFileButtonIsTapped))
    }
    
    @objc fileprivate func NewFileButtonIsTapped(){
        
        let destinationVC =  CreateFileController()
        destinationVC.project = self.project
        destinationVC.modalPresentationStyle = .overCurrentContext
        destinationVC.modalTransitionStyle = .crossDissolve
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    fileprivate func checkTheme() {
        
        if ThemeService.shared.isThemeDark(){
            
            DispatchQueue.main.async {
                self.navigationController?.navigationBar.barTintColor = .black
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.projectContentTableView.backgroundColor = .lightDark
                self.projectContentTableView.reloadData()
                UIApplication.shared.statusBarStyle = .lightContent
            }
            
            
        } else {
            
            DispatchQueue.main.async {
                
                self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeService.shared.getMainColor()]
                self.navigationController?.navigationBar.barTintColor = .white
                UIApplication.shared.statusBarStyle = .default
                self.projectContentTableView.backgroundColor = .lightGray
                self.projectContentTableView.reloadData()
            }
        }
    }
}
