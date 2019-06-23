//
//  ProjectsPageViewController+Extensions.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import SwipeCellKit
import UIKit

extension ProjectsPageViewController: UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllFilesCollectionViewCell.id, for: indexPath) as! AllFilesCollectionViewCell
        
        //cell.delegate = self
//        cell.file = files[indexPath.row]
        cell.fileNameLabel.text = self.projects[indexPath.row].name
        return cell
    }
//
//    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//
//        guard orientation == .right else { return nil }
//        let swipedFile = self.files[indexPath.row]
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//
//            let deleteAlert = UIAlertController(title: "Delete File", message: "Are you sure you want to delete this file? There is no going back.", preferredStyle: .alert)
//
//            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
//                CoreDataManager.shared.delete(file: swipedFile)
//                Helper.createStatusAlert(title: "Deleted", message: nil)
//                self.files.remove(at: indexPath.row)
//            })
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in
//                print("action canceled")
//            })
//
//            deleteAlert.addAction(deleteAction)
//            deleteAlert.addAction(cancelAction)
//            self.present(deleteAlert, animated: true, completion: nil)
//        }
//
//        let editAction = SwipeAction(style: .default, title: "Edit") { (action, indexPath) in
//
//            let destinationVC = TextEditorController()
//            destinationVC.editingFile = swipedFile
//            self.navigationController?.pushViewController(destinationVC, animated: true)
//        }
//
//        deleteAction.image = UIImage(named: "Trash_Icon")
//
//        return [deleteAction, editAction]
//    }
//    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        let destinationVC = ProjectDetailsViewController()
        let selectedProject = self.projects[indexPath.row]
        GithubService.shared.getRepoContents(projectName: selectedProject.name) { (result) in
            
            switch result{
            case let .success(contents):
                
                DispatchQueue.main.async {
                    destinationVC.contents = contents
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
