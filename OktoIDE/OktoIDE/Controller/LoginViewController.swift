//
//  LoginViewController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/18/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    

    lazy var userNameTextField: UITextField = {

        let textField = UITextField()
        textField.placeholder = "Username"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        
        let button = CustomButton(title: "Login",
                                  fontSize: 10,
                                  titleColor: .red,
                                  target: self,
                                  action: #selector(loginButtonIsTapped(sender:)),
                                  event: .touchUpInside,
                                  titleFontName: "Helvetica")

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        constraintUIElements()
    }
    
    @objc private func loginButtonIsTapped(sender: UIButton) {
        
        guard let username = userNameTextField.text, let password = passwordTextField.text else { return }
        
        
        GithubService.shared.login(username, password) { (result) in
            
            switch result{
            case let .success(user):
                
                print("success boi")
                
            case let   .failure(error):
                print("Authentication Error: \(error.localizedDescription)")
            }
        }
        
    }
    private func constraintUIElements() {
        
        let stackView = CustomStackView(subviews: [userNameTextField, passwordTextField, loginButton],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fillEqually)
        
        view.addSubview(stackView)
        stackView.fillSuperview()
    }
}
