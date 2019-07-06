//
//  HTTPNetworkBody.swift
//  OktoIDE
//
//  Created by Medi Assumani on 7/1/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

enum HTTPNetworkBody{
    
    case createFile(commitMessage: String, content: String)
    case updateFile(commitMessage: String, content: String, sha: String, branch: String)
    case deleteFile(commitMessage: String, sha: String, branch: String)
    
    var data: [String: String] {
        
        switch self {
            
        case .createFile(commitMessage: let aMessage, content: let aContent):
            
            return ["message": aMessage, "content": aContent]
            
        case .updateFile(commitMessage: let aMessage, content: let aContent, sha: let aSha, branch: let aBranch):
            
            return ["message": aMessage, "content": aContent, "sha": aSha, "branch": aBranch]
            
        case .deleteFile(commitMessage: let aMessage, sha: let aSha, branch: let aBranch):
            
            return ["message": aMessage, "sha": aSha, "branch": aBranch]
        }
    }
    
}
