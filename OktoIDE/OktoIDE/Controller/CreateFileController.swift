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
    var saveButton = CustomButton()
    var popUpContainer = UIView()
    var mainStackView = CustomStackView()
    let fileExtensionPickerView = UIPickerView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        setUpPopUpContainer()
        setUpTitleLabel()
        setUpAllTextFiledElements()
        setUpSaveButton()
        mainStackViewAutoLayout()
        addSwipeToDismis()
    }
    
    // MARK : CLASS METHODS
    
    
    @objc fileprivate func saveButtonTapped(sender: UIButton){
        
        guard let fileName = fileNameTextField.text, let fileExtension = fileExtensionTextField.text else { return }
        
        let file = CoreDataManager.shared.create()
        file.name = "\(fileName).\(fileExtension)"
        file.ext = fileExtension
        
        CoreDataManager.shared.save()
        
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
    
    
    fileprivate func setUpAllTextFiledElements(){
        
        fileNameTextField = CustomTextField(placeHolder: "Name",
                                             border: 1,
                                             cornerRadius: 5,
                                             borderColor: ThemeService.shared.getMainColor(),
                                             textColor: ThemeService.shared.getMainColor(),
                                             alignment: .left,
                                             borderStyle: .none)
        
        fileExtensionTextField = CustomTextField(placeHolder: "Extension",
                                                 border: 1,
                                                 cornerRadius: 5,
                                                 borderColor: ThemeService.shared.getMainColor(),
                                                 textColor: ThemeService.shared.getMainColor(),
                                                 alignment: .left,
                                                 borderStyle: .none)
        
        fileExtensionTextField.inputView = fileExtensionPickerView
        fileExtensionPickerView.delegate = self
    }
    
    fileprivate func setUpSaveButton(){
        
        saveButton = CustomButton(title: "Save", fontSize: 15, titleColor: .white, target: self, action: #selector(saveButtonTapped), event: .touchUpInside, titleFontName: "Helvetica")
        
        saveButton.backgroundColor = ThemeService.shared.getMainColor()
        saveButton.layer.cornerRadius = 10
    }
    
    fileprivate func mainStackViewAutoLayout(){
        
        mainStackView = CustomStackView(subviews: [titleLabel, fileNameTextField, fileExtensionTextField,saveButton],
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
          saveButton.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2),
            saveButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5)
            ])
    }
    
}

extension CreateFileController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return SyntaxHighlighService.languageColorDict.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SyntaxHighlighService.languageWithHighlight[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fileExtensionTextField.text = SyntaxHighlighService.languageWithHighlight[row]
    }
}
