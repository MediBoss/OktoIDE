//
//  Project.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/19/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

struct Project {
    
    let name: String
    let id: Int
    let language: String?
    let allContentsUrl: String
    let updatedTime: String
    
    init(name: String, id: Int, language: String?, allContentsUrl: String, updateTime: String) {
        
        self.name = name
        self.id = id
        self.language = language
        self.allContentsUrl = allContentsUrl
        self.updatedTime = updateTime
    }
    
    func getLanguageAssociatedColor() -> UIColor {
        
        var color: UIColor = .white
        
        SyntaxHighlighService.languageColorDict.forEach { (key, value) in
            if key == self.language {
                color = value
            }
        }
        return color
    }
}
