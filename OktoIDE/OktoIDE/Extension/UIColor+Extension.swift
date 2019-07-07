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
    

    static var lightGray = UIColor(red: 0.9686, green: 0.9686, blue: 0.9686, alpha: 1.0)
    static var lightDark = UIColor(red: 0.0667, green: 0.0667, blue: 0.0667, alpha: 1.0)
    static let darkModeBacgroundColor = #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1)
    static var currentBackgroundColor = UIColor.white
    static var mainIDEColorSyntax = UIColor(red: 0.3373, green: 0.1255, blue: 0.6471, alpha: 1.0)
    
    static let mainSyntaxColor = UIColor(red: 1, green: 0, blue: 0.6078, alpha: 1.0)
    static let swiftGithubRepoColor = UIColor(red: 1, green: 0.6745, blue: 0.2706, alpha: 1.0)
    static let pythonGithubRepoColor = UIColor(red: 0.2078, green: 0.4471, blue: 0.6471, alpha: 1.0)
    static let javascriptGithubRepoColor = UIColor(red: 0.9216, green: 0.9569, blue: 0.0667, alpha: 1.0)
    static let goGithubRepoColor = UIColor(red: 0, green: 0.6431, blue: 0.8275, alpha: 1.0)
    static let javaGithubRepoColor = UIColor(red: 0.6549, green: 0.4, blue: 0.0941, alpha: 1.0)
    static let cppGithubRepoColor = UIColor(red: 0.9451, green: 0.2549, blue: 0.4471, alpha: 1.0)
    static let htmlGithubRepoColor = UIColor(red: 0.9137, green: 0.2588, blue: 0.1333, alpha: 1.0)
    static let cssGithubRepoColor = UIColor(red: 0.298, green: 0.2118, blue: 0.4431, alpha: 1.0)
    static let jupyterGithubRepoColor = UIColor(red: 0.8353, green: 0.3137, blue: 0.0549, alpha: 1.0)
    static let rubyGithubRepoColor = UIColor(red: 0.3961, green: 0.0824, blue: 0.0863, alpha: 1.0)
}
