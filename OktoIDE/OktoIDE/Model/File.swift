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
    var body: String
    var ext: String
//    var editedAt: String
    
    init(name: String, ext: String) {
        
        self.name = name
        self.ext = ext
        self.body = ""
//        self.editedAt = getTodayDate()
    }
    
    func getLanguageAssociatedColor() -> UIColor {
        
        var color: UIColor = .white
        let separator = self.name.split(separator: ".")
        let fileExtension = String(separator.last ?? "")
        
        languageColorDict.forEach { (key, value) in
            if key == self.ext.lowercased() {
               color = value
            }
        }
        return color
    }
    
    static func getTodayDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
