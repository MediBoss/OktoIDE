//
//  HTTPNetworkRoute.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/20/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

enum HTTPNetworkRoute{
    
    case getRepoContents(projectName: String, isSubDir: Bool)
    case getSingleFileContents(projectName: String, fileName: String)
    case createFile(projectName: String, fileName: String)
    case updateFile(projectName: String, fileName: String)
    
    var username: String {
        return User.currentUser.username
    }
    
    var path: String {
        
        switch self {

        case .getRepoContents(projectName: let aProjectName, isSubDir: let isSubdir):
            
            if isSubdir{
                return "https://api.github.com/repos/\(self.username)/\(aProjectName)?ref=master"
            }
            return "https://api.github.com/repos/\(self.username)/\(aProjectName)/contents?ref=master"
            
        case .getSingleFileContents(projectName: let aProjectName, fileName: let aFileName):
            return "https://api.github.com/repos/\(self.username)/\(aProjectName)/contents/\(aFileName)?ref=master"
            
        case .createFile(projectName: let aProjectName, fileName: let aFileName):
            return "https://api.github.com/repos/\(self.username)/\(aProjectName)/contents/\(aFileName)?ref=master"
            
        case .updateFile(projectName: let aProjectName, fileName: let aFileName):
            return "https://api.github.com/repos/\(self.username)/\(aProjectName)/contents/\(aFileName)?ref=master"
        }
    }
    
    var headers: [String: Any] {
        
        switch self {
            
        case .createFile(projectName: _, fileName: _):
            fallthrough

        case .getRepoContents(projectName: _):
            fallthrough
        case .updateFile(projectName: _, fileName: _):
            fallthrough
        case .getSingleFileContents(projectName: _, fileName: _):
            fallthrough
        default:
            return ["client_id": SecretsConfig.client_id,
                    "client_secret": SecretsConfig.client_secret,
                    "Authorization": "token \(SecretsConfig.access_token)"]
        }
    }
}
