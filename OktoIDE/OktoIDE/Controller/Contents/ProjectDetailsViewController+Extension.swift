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
                    destinationVC.editingFile?.repoName = self.project.name
                    DispatchQueue.main.async { [weak self] in
                        
                        guard let self = self else { return }
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    }
                    
                case .failure(_):
                    print("j")
                }
            }
        } else {
            
            var isSubdir = false
            if selectedContent.type == ContentType.folder.rawValue {
                isSubdir = true
            }
            
            GithubService.shared.getRepoContents(projectName: "\(project.name)/contents/\(selectedContent.name)", isSubdir: isSubdir) { (result) in
                
                switch result{
                case let .success(moreContents):
                    moreContents.forEach({ self.contents.append($0) })
                    
                case .failure(_):
                    print("failure")
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

