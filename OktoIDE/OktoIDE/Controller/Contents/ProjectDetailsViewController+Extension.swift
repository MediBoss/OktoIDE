//
//  ProjectDetailsViewController+Extension.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/26/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

extension ProjectDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contents.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = projectContentTableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.id, for: indexPath) as! ContentTableViewCell
        
        cell.contentNameLabel.text = contents[indexPath.row].name
        cell.checkTheme()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedContent = self.contents[indexPath.row]
        
        if selectedContent.type == ContentType.file.rawValue {
            
            GithubService.shared.getSingleFileContent(content: selectedContent) { (result) in
                
                switch result {
                    
                case let .success(content):
                    
                    let destinationVC = TextEditorController()
                    destinationVC.editingFile = content
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    }
                    
                case .failure(_):
                    print("j")
                }
            }
        } else {
            
            print("oops")
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

