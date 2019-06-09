//
//  ThemeService.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/3/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class ThemeService{
    
    static let shared = ThemeService()
    static var lightBackground = UIColor.white
    
    func getMainColor() -> UIColor{
        
        return #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1)
    }
    
    func isThemeDark() -> Bool{
        let theme = UserDefaults.standard.bool(forKey: "isDarkMode")
        
        if theme == true {
            return true
        }
        
        return false
    }
}
