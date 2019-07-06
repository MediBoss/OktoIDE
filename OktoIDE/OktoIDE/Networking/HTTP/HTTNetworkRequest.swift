//
//  HTTNetworkRequest.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/20/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {
    
    /// Set the body, method, headers, and paramaters of the request
    static func configureHTTPRequest(path: String, params: HTTPParameters, headers: HTTPHeaders?, body: Data?, method: HTTPMethod) throws -> URLRequest {
        
        guard let url = URL(string: path) else { throw HTTPNetworkError.missingURL }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: params, headers: headers, request: &request)
        
        return request
    }
    
    /// Configure the request parameters and headers before the API Call
    static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                              headers: HTTPHeaders?,
                                              request: inout URLRequest) throws {
        
        do {
            
            if let headers = headers, let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
}
