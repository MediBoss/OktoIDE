//
//  HomePageViewController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageViewController: BaseUICollectionViewList {

    
    var files: [File] = [
        File(name: "networkManager.swift", editTimeStamp: "Wednesday 03 2019"),
        File(name: "driver.go", editTimeStamp: "Sunday 03 2019"),
        File(name: "server.js", editTimeStamp: "Friday 03 2019"),
        File(name: "user.py", editTimeStamp: "Thursday 03 2019"),
        File(name: "File.swift", editTimeStamp: "Tuesday 03 2019"),
        File(name: "__init__.py", editTimeStamp: "Monday 03 2019")
    ]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        collectionView.register(AllFilesCollectionViewCell.self, forCellWithReuseIdentifier: AllFilesCollectionViewCell.id)
    
    }
}
