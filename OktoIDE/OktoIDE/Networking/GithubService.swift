//
//  GithubServices.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/3/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import GithubAPI
import KeychainSwift


struct GithubService{
    
    static let shared = GithubService()
    
    /// Caches the user's username and password keychain
    private func cacheAuthObject(auth: BasicAuthentication){
        
        let keychain = KeychainSwift()
        
        keychain.set(auth.username, forKey: "username")
        keychain.set(auth.password, forKey: "password")
    }
    
    /// Retrieves and returns the user's credentials from keychain
    private func retrieveCachedObject() throws -> BasicAuthentication {
        
        let keychain = KeychainSwift()
        
        guard let username = keychain.get("username"), let password = keychain.get("password") else {
            throw NetworkError.KeychainNil
        }
        
        return BasicAuthentication(username: username, password: password)
    }
    
    func login(_ username: String, _ password: String, completion: @escaping(Result<User,Error>) -> ()) {
        
        let authentication = BasicAuthentication(username: username, password: password)
        self.cacheAuthObject(auth: authentication)
        
        UserAPI(authentication: authentication).getUser { (response, error) in
            
            if (error == nil) {
                
                guard
                    let name = response?.name,
                    let username = response?.login,
                    let avatarURL = URL(string: response?.avatarUrl ?? ""),
                    let id = response?.id else { return }
 
                let loggedInUser = User(name: name, username: username, id: id, avatarURL: avatarURL)
                User.setCurrentUser(loggedInUser, writeToUserDefaults: true)
                completion(.success(loggedInUser))
                
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    /// Fetches all of the user'repositories
    func getUserProjects(completion: @escaping(Result<[Project], Error>) ->()){
        
        do {
            
            let auth = try self.retrieveCachedObject()
            var projects = [Project]()
            
            RepositoriesAPI(authentication: auth).repositories(completion: { (response, err) in
                if err == nil {
                    
                    response?.forEach({ (project) in
                        
                        guard let name = project.name, let id = project.id, let language = project.language else { return }
                        
                        let newProject = Project(name: name, id: id, language: language)
                        projects.append(newProject)
                    })
                    completion(.success(projects))
                } else {
                    return completion(.failure(err!))
                }
            })
        } catch {
            print(NetworkError.KeychainNil.localizedDescription)
        }
    }
}
