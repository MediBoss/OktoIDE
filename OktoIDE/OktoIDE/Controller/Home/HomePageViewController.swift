//
//  HomePageViewController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageViewController: BaseUICollectionViewList, UICollectionViewDelegateFlowLayout {

    
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllFilesCollectionViewCell.id, for: indexPath) as! AllFilesCollectionViewCell
        
        var currentFile = files[indexPath.row]
        cell.file = currentFile
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        return CGSize(width: screenWidth/1.1, height: screenWidth/2)
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
