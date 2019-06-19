//
//  User.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/18/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable{
    
    let login: String
    let id: Int
    let avatarURL: URL
    private static var _current: User?
    
    static var currentUser: User {
        
        if let user = _current {
            return user
        } else {
            
            let data = UserDefaults.standard.value(forKey: "currentUser") as? Data
            let user = try! JSONDecoder().decode(User.self, from: data!)
            
            return user
        }
    }
    
    init(login: String, id: Int, avatarURL: URL) {
        
        self.login = login
        self.id = id
        self.avatarURL = avatarURL
    }
    
    /// Marks the logged in user as the current user, caches state to UserDefaults for future
    static func setCurrentUser(_ user: User, writeToUserDefaults: Bool = false) {
        
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: "currentUser")
            }
        }
        _current = user
    }
    
    /// Serializes the User object into a JSON format to be sent over HTTP
    func toDictionary() -> [String: Any] {
        
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        
        return json as! [String: Any]
    }
}
