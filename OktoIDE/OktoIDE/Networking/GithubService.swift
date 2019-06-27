//
//  GithubServices.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/3/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import KeychainSwift
import GithubAPI


struct GithubService{
    
    static let shared = GithubService()
    let githubSession = URLSession(configuration: .default)
    
    /// Logs in the user using their Github.com credentials
    func login(_ username: String, _ password: String, completion: @escaping(Result<User,Error>) -> ()) {
        
        let authentication = BasicAuthentication(username: username, password: password)
        KeychainManager.shared.cacheAuthObject(auth: authentication)
        
        UserAPI(authentication: authentication).getUser { (response, error) in
            
            if (error == nil && response?.id != nil) {
                
                guard
                    let name = response?.name,
                    let username = response?.login,
                    let avatarURL = URL(string: response?.avatarUrl ?? ""),
                    let id = response?.id else { return }
 
                let loggedInUser = User(name: name, username: username, id: id, avatarURL: avatarURL)
                User.setCurrentUser(loggedInUser, writeToUserDefaults: true)
                completion(.success(loggedInUser))
                
            } else {
                
                completion(.failure(HTTPNetworkError.badRequest))
            }
        }
    }
    
    /// Fetches all of the user'repositories
    func getUserProjects(completion: @escaping(Result<[Project], Error>) ->()){
        
        do {
            
            let auth = try KeychainManager.shared.retrieveCachedObject()
            var projects = [Project]()
            
            
            RepositoriesAPI(authentication: auth).repositories(completion: { (response, err) in
                if err == nil {
                    
                    response?.forEach({ (project) in
                        
                        guard let name = project.name,
                            let id = project.id,
                            let language = project.language,
                            let contentsUrl = project.contentsUrl,
                            let editTime = project.updatedAt else { return }
                        
                        let newProject = Project(name: name, id: id, language: language, allContentsUrl: contentsUrl, updateTime: editTime)
                        projects.append(newProject)
                    })
                    completion(.success(projects))
                } else {
                    return completion(.failure(err!))
                }
            })
        } catch {
            print(HTTPNetworkError.KeychainNil.localizedDescription)
        }
    }
    

    func getRepoContents(projectName: String, completion: @escaping(Result<[Content], HTTPNetworkError>) -> ()){
        
        let url = URL(string: "\(Routes.base.route)\(Routes.repos(projectName: projectName).route)")

        
        var request = URLRequest(url: url!)
        request.addValue(SecretsConfig.client_id, forHTTPHeaderField: "client_id")
        request.addValue(SecretsConfig.client_secret, forHTTPHeaderField: "client_secret")
        githubSession.dataTask(with: request) { (data, res, err) in
            
            if err == nil {
                
                guard let response = res as? HTTPURLResponse, let unwrappedData = data else { return }
                let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                
                switch result{
                case .success:
                    
                    guard let contents = try? JSONDecoder().decode([Content].self, from: unwrappedData) else { return completion(.failure(HTTPNetworkError.decodingFailed)) }
                    completion(.success(contents))
                case .failure:
                    completion(.failure(HTTPNetworkError.FragmentResponse))
                }
            }
        }.resume()
    }
    
    func downloadContents(content: Content, completion: @escaping(Result<Content, HTTPNetworkError>) -> ()) {
        
        let url = URL(string: content.url)
        var request = URLRequest(url: url!)

        request.addValue(SecretsConfig.client_id, forHTTPHeaderField: "client_id")
        request.addValue(SecretsConfig.client_secret, forHTTPHeaderField: "client_secret")
        
        githubSession.dataTask(with: request) { (data, res, err) in
            
            if err == nil {
                
                guard let response = res as? HTTPURLResponse, let unwrappedData = data else { return }
                let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                
                switch result{
                case .success:
                    
                    guard var file = try? JSONDecoder().decode(Content.self, from: unwrappedData) else { return }
                    
                    let index = file.name.firstIndex(of: ".")
                    file.ext = file.name.grabSubstring(start: index, on: file.name)
                    
                    completion(.success(file))
                    
                case .failure:
                    completion(.failure(HTTPNetworkError.FragmentResponse))
                }
            }
        }.resume()
    }
}
