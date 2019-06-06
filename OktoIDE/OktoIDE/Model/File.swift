//
//  File.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


struct File {
    
    var name: String
    var body: String
    var ext: String
    
    init(name: String, ext: String) {
        
        self.name = name
        self.ext = ext
        self.body = ""
    }
    
    func getLanguageAssociatedColor() -> UIColor {
        
        var color: UIColor = .white
        let separator = self.name.split(separator: ".")
        
        SyntaxHighlighService.languageColorDict.forEach { (key, value) in
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
