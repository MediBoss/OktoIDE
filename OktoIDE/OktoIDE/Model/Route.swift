//
//  Route.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation


enum Routes{
    case base // Get the base URL of the Githubp V3 API
    case repos(projectName: String) // Get all the current user's repository
    case contens(projectName: String, contentName: String) // get content for a file from a repository
}

extension Routes {
    
    var route: String {
        switch self {
            
        case .base:
            return "https://api.github.com"
        case .repos(projectName: let aProjectName):
            return "/repos/MediBoss/\(aProjectName)/contents?ref=master"
        case .contens(projectName: let aProjectName, contentName: let aContentName):
            return "https://api.github.com/repos/MediBoss/\(aProjectName)/contents/\(aContentName)?ref=master"
        }
    }
}

