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
    let language: String
    let allContentsUrl: String
    
    init(name: String, id: Int, language: String, allContentsUrl: String) {
        
        self.name = name
        self.id = id
        self.language = language
        self.allContentsUrl = allContentsUrl
    }
}
