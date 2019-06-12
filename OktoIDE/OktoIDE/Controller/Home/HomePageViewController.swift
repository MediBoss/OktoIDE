//
//  HomePageViewController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator


extension Notification.Name{
    static let didReceiveFileObject = Notification.Name("didReceivedFileObject")
}

class HomePageViewController: BaseUICollectionViewList {

    private var animationCounter = 0
    private  let animations = [AnimationType.from(direction: .right, offset: 30.0)]
    var files: [File] = [File](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if ThemeService.shared.isThemeDark(){
            collectionView.backgroundColor = .black
            
        } else {
            collectionView.backgroundColor = .lightGray
        }
        collectionView.register(AllFilesCollectionViewCell.self, forCellWithReuseIdentifier: AllFilesCollectionViewCell.id)
        configureNavBar()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onDidReceiveNewFile(sender:)),
                                               name: .didReceiveFileObject,
                                               object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        CoreDataManager.shared.fetchTrips { (fetchResults) in

            switch fetchResults {
            case let .success(fetchedFilesCallback):
                self.files = fetchedFilesCallback
                self.animateCells()
            case let .failure(error):
                // TODO : Add proper production error handling
                print("Error found \(error.localizedDescription)")
            }
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didReceiveFileObject, object: nil)
    }
    
    /// Animates the home page table view cells when app starts
    private func animateCells(){
        
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
    
    @objc fileprivate func onDidReceiveNewFile(sender: Notification) {
        
        if let receivedFile = sender.object as? File {
            self.files.append(receivedFile)
        }
    }

    fileprivate func configureNavBar(){
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(addFile(sender:)))
    }
    
    @objc func addFile(sender: UIBarButtonItem){
        
    
        let destinationVC = CreateFileController()
        destinationVC.modalPresentationStyle = .overCurrentContext
        destinationVC.modalTransitionStyle = .crossDissolve
        self.present(destinationVC, animated: true, completion: nil)
    }
}
