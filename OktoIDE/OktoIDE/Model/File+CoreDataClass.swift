//
//  File+CoreDataClass.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/8/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//
//

import CoreData
import Foundation
import UIKit

@objc(File)
public class File: NSManagedObject {

    func getLanguageAssociatedColor() -> UIColor {
        
        var color: UIColor = .white
        
        SyntaxHighlighService.languageColorDict.forEach { (key, value) in
            if key == self.ext {
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
