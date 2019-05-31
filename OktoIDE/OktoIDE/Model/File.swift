//
//  File.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

public var languageColorDict = ["swift": UIColor.swiftKeywordColorHighlight,"py": UIColor.pythonKeywordColorHighlight,"js": UIColor.javascriptKeywordColorHighlight,"go": UIColor.goKeywordColorHighlight]
struct File {
    
    var name: String
    var editTimeStamp: String
    
    init(name: String, editTimeStamp: String) {
        
        self.name = name
        self.editTimeStamp = editTimeStamp
    }
    
    func getLanguageAssociatedColor() -> UIColor {
        
        var color: UIColor = .white
        let separator = self.name.split(separator: ".")
        let fileExtension = String(separator.last ?? "")
        
        languageColorDict.forEach { (key, value) in
            if key == fileExtension {
               color = value
            }
        }
        return color
    }
}
