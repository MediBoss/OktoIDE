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
    
    var mainStackView: CustomStackView!

    
    lazy var userNameLabel = CustomLabel(fontSize: 20,
                                         text: "Medi Assumani",
                                         textColor: .red,
                                         textAlignment: .center,
                                         fontName: "Helvetica")
    
    lazy var logoutButton = CustomButton(title: "LOGOUT",
                                    fontSize: 10,
                                    titleColor: .white,
                                    target: self,
                                    action: #selector(logoutButtonTapped(_:)),
                                    event: .touchUpInside,
                                    titleFontName: "Helevetica")
    
    lazy var appThemeSwitch: UISwitch = {
       
    var themeSwitch = UISwitch()
        
        themeSwitch.isOn = false
        themeSwitch.onTintColor = .swiftKeywordColorHighlight
        themeSwitch.addTarget(self, action: #selector(themeSwitchToggled(_:)), for: .valueChanged)
        return themeSwitch
    }()
    
    var profileImageView: UIImageView {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        //logoutButton.backgroundColor = .black
        //layoutUIElements()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: appThemeSwitch)
    }
    
    @objc fileprivate func themeSwitchToggled(_ sender: UISwitch){
        
        if sender.isOn {
            
            UserDefaults.standard.set(true, forKey: "isDarkMode")
        } else {
            UserDefaults.standard.set(false, forKey: "isDarkMode")
        }
    }
    fileprivate func layoutUIElements() {
        
        mainStackView = CustomStackView(subviews: [profileImageView, userNameLabel, logoutButton],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fill)
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            profileImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.1),
            profileImageView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.5),
            userNameLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.4),
            userNameLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.02),
            logoutButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.03),
            logoutButton.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2)
        ])
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        // log out user
    }
}
