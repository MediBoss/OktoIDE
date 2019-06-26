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
    

    lazy var logoImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var userNameTextField: UITextField = {

        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont(name: "Helvetica", size: 20)
        textField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont(name: "Helvetica", size: 20)
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
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
        
        let textInputStackView = CustomStackView(subviews: [userNameTextField, passwordTextField],
                                                 alignment: .center,
                                                 axis: .vertical,
                                                 distribution: .fill)
        
        let mainStackView = CustomStackView(subviews: [logoImageView, textInputStackView, loginButton],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fillEqually)
        
        view.addSubview(mainStackView)
        //mainStackView.fillSuperview()
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            mainStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            mainStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.95),
        ])
    }
}
