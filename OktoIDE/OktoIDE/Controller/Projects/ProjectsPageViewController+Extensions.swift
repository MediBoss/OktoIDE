//
//  ProjectsPageViewController+Extensions.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

extension ProjectsPageViewController: UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectsCollectionViewCell.id, for: indexPath) as! ProjectsCollectionViewCell
        

        cell.project = self.projects[indexPath.row]
        cell.checkTheme()
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        let destinationVC = ProjectDetailsViewController()
        let selectedProject = self.projects[indexPath.row]
        GithubService.shared.getRepoContents(projectName: selectedProject.name, isSubdir: false) { (result) in
            
            switch result{
            case let .success(contents):
                
                DispatchQueue.main.async {
                    destinationVC.contents = contents
                    destinationVC.project = selectedProject
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        return CGSize(width: screenWidth/1.1, height: screenWidth/2.7)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
