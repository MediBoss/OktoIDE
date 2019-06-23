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
        view.addSubview(projectContentTableView)
        projectContentTableView.fillSuperview()
        projectContentTableView.delegate = self
        projectContentTableView.dataSource = self
        
        projectContentTableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.id)
        
        
    }
}

extension ProjectDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contents.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = projectContentTableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.id, for: indexPath) as! ContentTableViewCell
        
        cell.contentNameLabel.text = contents[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedContent = self.contents[indexPath.row]
        
        if selectedContent.type == ContentType.file.rawValue {
            
            GithubService.shared.downloadContents(content: selectedContent) { (result) in
                
                switch result {
                    
                case let .success(content):
                    
                    let destinationVC = TextEditorController()
                    destinationVC.editingFile = content
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    }
                
                case .failure(_):
                    print("uh oh")
                }
            }
            
        } else {
            print("It's a directory, download its content")
        }
    }
}
