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

enum Routes{
    case base // Get the base URL of the Githubp V3 API
    case repos(projectName: String) // Get all the current user's repository
    case contens(projectName: String, contentName: String) // get content for a file from a repository
}

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
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
struct GithubService{
    
    static let shared = GithubService()
    let githubSession = URLSession(configuration: .default)
    
    
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
            throw HTTPNetworkError.KeychainNil
        }
        
        return BasicAuthentication(username: username, password: password)
    }
    
    /// Logs in the user using their Github.com credentials
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
                        
                        guard let name = project.name, let id = project.id, let language = project.language, let contentsUrl = project.contentsUrl else { return }
                        
                        let newProject = Project(name: name, id: id, language: language, allContentsUrl: contentsUrl)
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
    
//    func urlWithParameters(url: String, parameters: [String: String]?) -> String {
//        var retUrl = url
//        if let parameters = parameters {
//            if parameters.count > 0 {
//                retUrl.append("?")
//                parameters.keys.forEach {
//                    guard let value = parameters[$0] else { return }
//                    let escapedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.BaseAPI_URLQueryAllowedCharacterSet())
//                    if let escapedValue = escapedValue {
//                        retUrl.append("\($0)=\(escapedValue)&")
//                    }
//                }
//                retUrl.removeLast()
//            }
//        }
//        return retUrl
//    }
    
    func getRepoContents(projectName: String, completion: @escaping(Result<[Content], HTTPNetworkError>) -> ()){
        
        let client_id = "8a673fc74bd93937138d"
        let client_secret = "b36b58ae39ddd6b1516eb66582e03f84c13cb368"

        let session = URLSession(configuration: .default)
        let url = URL(string: "\(Routes.base.route)\(Routes.repos(projectName: projectName).route)")

        
        var request = URLRequest(url: url!)
        request.addValue(client_id, forHTTPHeaderField: "client_id")
        request.addValue(client_secret, forHTTPHeaderField: "client_secret")
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
        let client_id = "8a673fc74bd93937138d"
        let client_secret = "b36b58ae39ddd6b1516eb66582e03f84c13cb368"
        request.addValue(client_id, forHTTPHeaderField: "client_id")
        request.addValue(client_secret, forHTTPHeaderField: "client_secret")
        githubSession.dataTask(with: request) { (data, res, err) in
            
            if err == nil {
                
                guard let response = res as? HTTPURLResponse, let unwrappedData = data else { return }
                let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                
                switch result{
                case .success:
                    
                    guard let file = try? JSONDecoder().decode(Content.self, from: unwrappedData) else { return }

                    completion(.success(file))
                case .failure:
                    completion(.failure(HTTPNetworkError.FragmentResponse))
                }
            }
        }.resume()
    }
}
