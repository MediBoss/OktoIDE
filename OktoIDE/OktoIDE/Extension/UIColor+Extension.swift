//
//  UIColor+Extension.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

import UIKit

// This file contains custom extended UIColors   - Thanks to Ralf Ebert for his amazing color picker tool
extension UIColor{
    
    static var gloomyBlue = UIColor(red: 20/255, green: 100/255, blue: 175/255, alpha: 1)
    static var gloomyGreen = UIColor(red: 0.0784, green: 0.6275, blue: 0.2157, alpha: 1.0)
    static var gloomyYellow = UIColor(red: 0.8863, green: 0.8118, blue: 0.1137, alpha: 1.0)
    static var lightGray = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1.0)
    static var lightCyan = UIColor(red: 0.9686, green: 0.9843, blue: 1, alpha: 1.0)
    static var lightBlue = UIColor(red: 109/255, green: 188/255, blue: 237/255, alpha: 1.0)
    static var lightDark = UIColor(red: 0.0667, green: 0.0667, blue: 0.0667, alpha: 1.0) /* #111111 */
    static var lightPink = UIColor(red: 1, green: 0.3882, blue: 0.9176, alpha: 1.0)
    static var cyanGreen = UIColor(red: 0.0627, green: 0.8078, blue: 0.6824, alpha: 1.0)
    static var customGreen = UIColor(red: 0.4235, green: 0.7569, blue: 0.1647, alpha: 1.0)
    static let darkBlue = UIColor(red: 0.1294, green: 0.2706, blue: 0.3765, alpha: 1.0)
    static let pythonPurple = UIColor(red: 0.6353, green: 0, blue: 0.749, alpha: 1.0) /* #a200bf */
    static let mainSyntaxColor = UIColor(red: 1, green: 0, blue: 0.6078, alpha: 1.0)
    static let swiftGithubRepoColor = UIColor(red: 1, green: 0.6745, blue: 0.2706, alpha: 1.0)
    static let pythonKeywordColorHighlight = UIColor(red: 0.2078, green: 0.4471, blue: 0.6471, alpha: 1.0)
    static let goKeywordColorHighlight = UIColor(red: 0.2039, green: 0.6314, blue: 1, alpha: 1.0)
    static let javascriptKeywordColorHighlight = UIColor(red: 0.9216, green: 0.9569, blue: 0.0667, alpha: 1.0)
    static let darkModeBacgroundColor = #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1)
    static var currentBackgroundColor = UIColor.white

}
