//
//  ProfilePageController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/29/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


class ProfilePageController: UIViewController {
    
    lazy var appThemeSwitch: UISwitch = {
       
        var themeSwitch = UISwitch()
        
        themeSwitch.isOn = true
        themeSwitch.onTintColor = .swiftKeywordColorHighlight
        return themeSwitch
    }()
    
    lazy var label = CustomLabel(fontSize: 20, text: "Medi", textColor: .red, textAlignment: .center, fontName: "Helvetica")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        appThemeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
        appThemeSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10)
        view.addSubview(appThemeSwitch)
        appThemeSwitch.fillSuperview()
        
    }
}
