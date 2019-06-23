//
//  HTTPNetworkRoute.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/20/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public enum HTTPNetworkRoute: String{
    
    case allSpaces = "https://api.yelp.com/v3/businesses/search?"
    case singleSpace = "https://api.yelp.com/v3/businesses/"
    case weather = "https://api.darksky.net/forecast/"
}
