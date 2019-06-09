//
//  HomePageViewController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

extension Notification.Name{
    static let didReceiveFileObject = Notification.Name("didReceivedFileObject")
}

class HomePageViewController: BaseUICollectionViewList {

    
//    var files: [File] = [File](){
//        didSet{
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }
    
    var files: [File] = [
        
        File(name: "File.swift", ext: "swift"),
        File(name: "mailer.js", ext: "js"),
        File(name: "manage.py", ext: "py"),
        File(name: "server.go", ext: "go"),
        File(name: "scheduler.js", ext: "js"),
        File(name: "HomePageViewController", ext: "swift"),
        File(name: "__init__.py", ext: "py")
    ]
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didReceiveFileObject, object: nil)
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
