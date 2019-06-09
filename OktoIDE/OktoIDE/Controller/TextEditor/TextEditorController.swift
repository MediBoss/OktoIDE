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
        textEditor.backgroundColor = ThemeService.lightBackground
        textEditor.textColor = .green
        textEditor.autocapitalizationType = .none
        textEditor.enablesReturnKeyAutomatically = true
        textEditor.text = self.editingFile?.content
        textEditor.font = UIFont(name: "Helvetica", size: 20)

        return textEditor
    }()
    
    //- MARK: VIEW CONTROLLER LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editingFile?.content = "import Foundation \nimport Alamofire \n\ntypealias HTTPParams = [String: Any]?\n\nstruct File { \n\n   var name: String\n   var content: String\n   private var ext: String\n\n   init(name: String, ext: String) {\n      self.name = name\n           self.ext = ext\n   }\n\n   func getFileName() -> String{\n      return self.name\n   }\n\n   func setFileName(name: String){\n      self.name = name\n   }\n\n\n   func sync(comp: @escaping()->()){\n\n      if self != nil {\n         GithubService.shared.syncFile()\n   }\n}"
        
        view.addSubview(mainTextEditorTextView)
        SyntaxHighlighService.shared.highlightText(for: "swift", in: mainTextEditorTextView)
        mainTextEditorTextView.fillSuperview()
        addAcessory()
        mainTextEditorTextView.delegate = self as UITextViewDelegate
        configureNavBar()
    }
    
    //- MARK: CLASS METHODS
    
    /// Add a view on top of the text editor keyboard that will contain accessories.
    func addAcessory() {
        
        textEditorkeyboardAccessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        mainTextEditorTextView.inputAccessoryView = textEditorkeyboardAccessory
        constraintAccessoryViewItems()
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
    
    @objc fileprivate func saveButtonIsTap(sender: UIBarButtonItem) {
        
        //editingFile?.content = mainTextEditorTextView.text
        dismiss(animated: true, completion: nil)
    }
    fileprivate func configureNavBar(){
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonIsTap(sender:)))
    }
}
