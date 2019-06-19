//
//  GithubServices.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/3/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import GithubAPI

struct GithubService{
    
    static let shared = GithubService()
    
    func login(_ username: String, _ password: String, completion: @escaping(Result<User,Error>) -> ()) {
        
        let authentication = BasicAuthentication(username: username, password: password)
        UserAPI(authentication: authentication).getUser { (response, error) in
            
            if (error == nil) {
                
                guard
                    let username = response?.login,
                    let avatarURL = URL(string: response?.avatarUrl ?? ""),
                    let id = response?.id else { return }
                
                let loggedInUser = User(login: username, id: id, avatarURL: avatarURL)
                User.setCurrentUser(loggedInUser, writeToUserDefaults: true)
                completion(.success(loggedInUser))
                
            } else {
                completion(.failure(error!))
            }
        }
    }
}
