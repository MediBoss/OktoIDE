//
//  Constant.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import StatusAlert
import UIKit

struct Helper{
    
    static func createStatusAlert(title: String, message: String?){
        
        let statusAlert = StatusAlert()
            
        statusAlert.image = UIImage(named: "trash")
        statusAlert.title = title
        statusAlert.canBePickedOrDismissed = true
        statusAlert.showInKeyWindow()
    }
}

