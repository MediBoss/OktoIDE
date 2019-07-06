//
//  Content.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/21/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


public enum ContentType: String {
    
    case file = "file"
    case folder = "dir"
    case subfolder = "sub-dir"
}

struct Content: Codable {
    
    var name: String
    var path: String
    var sha: String
    var url: String
    var git_url: String
    var type: String
    var content: String?
    var encoding: String?
    var ext: String?
    var repoName: String?
}


