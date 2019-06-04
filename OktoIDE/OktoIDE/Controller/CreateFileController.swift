////
////  CreateFileController.swift
////  OktoIDE
////
////  Created by Medi Assumani on 6/3/19.
////  Copyright © 2019 Medi Assumani. All rights reserved.
////
//

//
import Foundation
import UIKit

class CreateFileController: UIViewController{
    // This View Controller class handles functionality to create a new group
    
    var titleLabel = CustomLabel()
    var fileNameTextField =  CustomTextField()
    var fileExtensionTextField = CustomTextField()
    var createButton = CustomButton()
    var popUpContainer = UIView()
    var mainStackView = CustomStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        
        setUpPopUpContainer()
        setUpTitleLabel()
        setUpGroupNameTextFiled()
        setUpGroupAddressTextfield()
        setUpSaveButton()
        mainStackViewAutoLayout()
        addSwipeToDismis()
    }
    
    // MARK : CLASS METHODS
    
    
    @objc fileprivate func createButtonTapped(sender: UIButton){
        print("create")
        
        guard let fileName = fileNameTextField.text, let fileExtension = fileExtensionTextField.text else { return }
        
        let file = File(name: fileName, ext: fileExtension)
        
        NotificationCenter.default.post(name: .didReceiveFileObject, object: file)
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func addSwipeToDismis() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleMainViewDragged(_:)))
        popUpContainer.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func handleMainViewDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        if gestureRecognizer.state == .ended{
            self.dismiss(animated: true, completion: nil)
        }
    }

    fileprivate func setUpPopUpContainer(){
        
        popUpContainer = UIView(frame: view.frame)
        popUpContainer.backgroundColor = .white
        popUpContainer.layer.cornerRadius = 15
        popUpContainer.clipsToBounds = true
        popUpContainer.layer.masksToBounds = true
        popUpContainer.layer.shadowRadius = 1
        popUpContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popUpContainer)
    }
    
    fileprivate func setUpTitleLabel(){
        
        titleLabel = CustomLabel(fontSize: 20, text: "New File", textColor: ThemeService.shared.getMainColor(), textAlignment: .center, fontName: "Helvetica")
    }
    
    
    fileprivate func setUpGroupNameTextFiled(){
        
        fileNameTextField = CustomTextField(placeHolder: "Name",
                                             border: 1,
                                             cornerRadius: 5,
                                             borderColor: ThemeService.shared.getMainColor(),
                                             textColor: ThemeService.shared.getMainColor(),
                                             alignment: .left,
                                             borderStyle: .none)
    }
    
    fileprivate func setUpGroupAddressTextfield(){
        
        fileExtensionTextField = CustomTextField(placeHolder: "Extension",
                                                border: 1,
                                                cornerRadius: 5,
                                                borderColor: ThemeService.shared.getMainColor(),
                                                textColor: ThemeService.shared.getMainColor(),
                                                alignment: .left,
                                                borderStyle: .none)
        //groupAddressTextField.delegate = self
    }
    
    fileprivate func setUpSaveButton(){
        
        createButton = CustomButton(title: "Save", fontSize: 15, titleColor: .white, target: self, action: #selector(createButtonTapped), event: .touchUpInside, titleFontName: "Helvetica")
        
        createButton.backgroundColor = ThemeService.shared.getMainColor()
        createButton.layer.cornerRadius = 10
    }
    
    fileprivate func mainStackViewAutoLayout(){
        
        mainStackView = CustomStackView(subviews: [titleLabel, fileNameTextField, fileExtensionTextField,createButton],
                                    alignment: .center,
                                    axis: .vertical,
                                    distribution: .fill)
        mainStackView.spacing = 5
        popUpContainer.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([popUpContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     popUpContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     popUpContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width/1.1),
                                     popUpContainer.heightAnchor.constraint(equalToConstant: self.view.frame.height/3.0),
                                     mainStackView.topAnchor.constraint(equalTo: popUpContainer.topAnchor, constant: 10),
                                     mainStackView.leadingAnchor.constraint(equalTo: popUpContainer.leadingAnchor, constant: 10),
                                     mainStackView.trailingAnchor.constraint(equalTo: popUpContainer.trailingAnchor, constant: 10),
                                     mainStackView.heightAnchor.constraint(equalTo: popUpContainer.heightAnchor, multiplier: 0.95),
                                     mainStackView.widthAnchor.constraint(equalTo: popUpContainer.widthAnchor, multiplier: 0.95),
                                     titleLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.15),
                                     fileNameTextField.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.25),
                                     fileNameTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),
                                     fileExtensionTextField.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.25),
                                     fileExtensionTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),
          createButton.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2),
            createButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5)
            ])
    }
    
}

