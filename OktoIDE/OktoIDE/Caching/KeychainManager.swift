//
//  KeychainManager.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import GithubAPI
import KeychainSwift


struct KeychainManager {
    
    static let shared = KeychainManager()
    
    /// Caches the user's username and password keychain
    func cacheAuthObject(auth: BasicAuthentication){
        
        let keychain = KeychainSwift()
        
        keychain.set(auth.username, forKey: "username")
        keychain.set(auth.password, forKey: "password")
    }
    
    /// Retrieves and returns the user's credentials from keychain
    func retrieveCachedObject() throws -> BasicAuthentication {
        
        let keychain = KeychainSwift()
        
        guard let username = keychain.get("username"), let password = keychain.get("password") else {
            throw HTTPNetworkError.KeychainNil
        }
        
        return BasicAuthentication(username: username, password: password)
    }
}
