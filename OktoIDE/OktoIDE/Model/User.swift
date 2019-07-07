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
    
    let name: String
    let username: String
    let email: String

    private static var _current: User?
    
    static var currentUser: User {
        
        if let user = _current {
            return user
        } else {
            
            var user: User!
            do {
                let data = UserDefaults.standard.value(forKey: "currentUser") as? Data
                user = try? JSONDecoder().decode(User.self, from: data!)
            } catch {
                print("Error getting current user")
            }
            return user
        }
    }
    
    init(name: String, username: String, email: String) {
        
        self.name = name
        self.username = username
        self.email = email
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
}
