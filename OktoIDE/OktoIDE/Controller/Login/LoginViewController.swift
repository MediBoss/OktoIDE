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
    

    lazy var customAlertView: CustomAlertView = {
        
        let view = CustomAlertView(title: "Oops",
                                   message: "Please make sure to enter your credentials")
        return view
    }()
    
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
        textField.backgroundColor = .black
        textField.setPadding()
        textField.setBottomBorder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont(name: "Helvetica", size: 20)
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       
        textField.backgroundColor = .black
        textField.setPadding()
        textField.setBottomBorder()
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        
        let button = CustomButton(title: "Login with Github",
                                  fontSize: 15,
                                  titleColor: .black,
                                  target: self,
                                  action: #selector(loginButtonIsTapped(sender:)),
                                  event: .touchUpInside,
                                  titleFontName: "Helvetica")
        
        button.setImage(UIImage(named: "github-logo"), for: .normal)
        button.imageView?.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.5)
        button.imageView?.heightAnchor.constraint(equalTo: button.heightAnchor)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 7)
        button.semanticContentAttribute = .forceLeftToRight
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        constraintUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
    @objc private func loginButtonIsTapped(sender: UIButton) {
        
        loginButton.pulsate()
        guard let username = userNameTextField.text, let password = passwordTextField.text else { return }
        if (username.count == 0 || password.count == 0) {
            customAlertView.show(animated: true)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            
            GithubService.shared.login(username, password) { (result) in
                
                switch result{
                case .success(_):
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        guard let self = self else { return }
                        let destinationVC = ProjectsPageViewController()
                        self.present(destinationVC, animated: true, completion: nil)
                    }
                    
                case .failure(_):
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        guard let self = self else { return }
                        self.customAlertView.titleLabel.text = "Incorrect credentials"
                        self.customAlertView.messageLabel.text = "Please check your username or password"
                        self.customAlertView.show(animated: true)
                    }
                }
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
                                        distribution: .fill)
        
        view.addSubview(mainStackView)

        
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainStackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            mainStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),

            logoImageView.widthAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            userNameTextField.widthAnchor.constraint(equalTo: textInputStackView.safeAreaLayoutGuide.widthAnchor),
            userNameTextField.heightAnchor.constraint(equalTo: textInputStackView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            passwordTextField.widthAnchor.constraint(equalTo: textInputStackView.safeAreaLayoutGuide.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: textInputStackView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            textInputStackView.widthAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            textInputStackView.heightAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            loginButton.widthAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            loginButton.heightAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.09)
        ])
    }
}
