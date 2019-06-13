//
//  TextEditorController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


class TextEditorController: UIViewController {
    
    //- MARK: CLASS PROPERTIES
    var editingFile: File?
    
    lazy var textEditorkeyboardAccessory: UIView = {
        
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .lightGray
        accessoryView.alpha = 0.6
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        
        return accessoryView
    }()
    
    lazy var tabButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setTitle("Tab", for: .normal)
        button.addTarget(self, action: #selector(cursorIsTabbed(sender:)), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var moveCursorToLeftButton: UIButton = {
        
        let button = UIButton(type: .custom)

        button.setImage(UIImage(named: "left-arrow"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cursorIsMovedToLeft(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    lazy var moveCursorToRighttButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: "right-arrow"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cursorIsMovedToRight(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var highlightAllTextButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "marker"), for: .normal)
        button.addTarget(self, action: #selector(allTextIsSelected(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var mainTextEditorTextView: UITextView = {
       
        let textEditor = UITextView()
        textEditor.textColor = .white
        textEditor.enablesReturnKeyAutomatically = false
        textEditor.autocapitalizationType = .none
        textEditor.autocorrectionType = .no
        textEditor.text = self.editingFile?.content
        textEditor.font = UIFont(name: "Helvetica", size: 20)

        return textEditor
    }()
    
    //- MARK: VIEW CONTROLLER LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainTextEditorTextView)
        
        Helper.getEditorSyntaxtHighlight(ext: editingFile?.ext, textView: mainTextEditorTextView)
        mainTextEditorTextView.fillSuperview()
        addAcessory()
        mainTextEditorTextView.delegate = self as UITextViewDelegate
        configureNavBar()
        adjustTheme()
    }
    
    //- MARK: CLASS METHODS
    
    /// Add a view on top of the text editor keyboard that will contain accessories.
    func addAcessory() {
        
        textEditorkeyboardAccessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        mainTextEditorTextView.inputAccessoryView = textEditorkeyboardAccessory
        constraintAccessoryViewItems()
    }
    
    fileprivate func adjustTheme() {
        
        if ThemeService.shared.isThemeDark(){
            mainTextEditorTextView.backgroundColor = .black
            mainTextEditorTextView.textColor = .white
        } else {
            mainTextEditorTextView.backgroundColor = .lightGray
            mainTextEditorTextView.textColor = .black
        }
    }
    
    /// Horizontally stack up buttons to tab, highlight, and move the cursor on top of the keyboard
    fileprivate func constraintAccessoryViewItems() {
        
        let accessoryItemstackView = CustomStackView(subviews: [moveCursorToLeftButton,
                                                                moveCursorToRighttButton,
                                                                tabButton,
                                                                highlightAllTextButton],
                                        alignment: .center,
                                        axis: .horizontal,
                                        distribution: .fillEqually)
        textEditorkeyboardAccessory.addSubview(accessoryItemstackView)
        accessoryItemstackView.fillSuperview()
    }
    
    /// Move the cursor backward by one character/space
    @objc fileprivate func cursorIsMovedToLeft(sender: UIButton) {
        
        if let selectedRange = mainTextEditorTextView.selectedTextRange {
            
            if let newPosition = mainTextEditorTextView.position(from: selectedRange.start, offset: -1) {

                mainTextEditorTextView.selectedTextRange = mainTextEditorTextView.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    /// Move the cursor forward by one character/space
    @objc fileprivate func cursorIsMovedToRight(sender: UIButton) {
        
        if let selectedRange = mainTextEditorTextView.selectedTextRange {
            
            if let newPosition = mainTextEditorTextView.position(from: selectedRange.start, offset: 1) {
                
                mainTextEditorTextView.selectedTextRange = mainTextEditorTextView.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    /// Highlight the entire text editor
    @objc fileprivate func allTextIsSelected(sender: UIButton) {
        
        mainTextEditorTextView.selectedTextRange = mainTextEditorTextView.textRange(from: mainTextEditorTextView.beginningOfDocument, to: mainTextEditorTextView.endOfDocument)
    }
    
    /// Moves the cursor to the right by 4 characters to mimick the tab key
    @objc fileprivate func cursorIsTabbed(sender: UIButton) {
        
        mainTextEditorTextView.insertText("    ")
    }
    
    @objc fileprivate func saveButtonIsTapped() {
        
        let date = Date()
        editingFile?.content = mainTextEditorTextView.text
        editingFile?.editedAt = Date().toPrettyString()
        CoreDataManager.shared.save()
        navigationController?.popViewController(animated: true)

    }
    
    fileprivate func configureNavBar(){
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonIsTapped))
    }
}
