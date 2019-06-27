//
//  BaseUICollectionList.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


class BaseUICollectionViewList: UICollectionViewController{
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
