//
//  Constant.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct Helper{
    
    static func createStatusAlert(title: String, message: String, choice: Selection){
        
        let statusAlert = StatusAlert()
        
        switch choice {
        case .selected:
            
            statusAlert.image = UIImage(named: "selected")
            statusAlert.title = title
            statusAlert.message = message
            statusAlert.canBePickedOrDismissed = true
            
        case .deselected:
            
            statusAlert.image = UIImage(named: "deselect")
            statusAlert.title = title
            statusAlert.message = message
            statusAlert.canBePickedOrDismissed = true
        }
        
        statusAlert.showInKeyWindow()
    }
}

