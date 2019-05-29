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
        
        //button.setTitle("Highlight", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "marker"), for: .normal)
        button.addTarget(self, action: #selector(allTextIsSelected(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var mainTextEditorTextView: UITextView = {
       
        let textEditor = UITextView()
        textEditor.backgroundColor = .white
        textEditor.font = UIFont.italicSystemFont(ofSize: 15)
        textEditor.textColor = .gloomyGreen
        textEditor.autocapitalizationType = .none
        textEditor.text = "// This is your text editor. Use it as a scratch pad"
        textEditor.enablesReturnKeyAutomatically = true

        return textEditor
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainTextEditorTextView)
        mainTextEditorTextView.fillSuperview()
        addAcessory()
    }
    
    func addAcessory() {
        
        textEditorkeyboardAccessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        mainTextEditorTextView.inputAccessoryView = textEditorkeyboardAccessory
        constraintAccessoryViewItems()
    
    }
    
    func constraintAccessoryViewItems() {
        
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
    
    
    @objc fileprivate func cursorIsMovedToLeft(sender: UIButton) {
        
        if let selectedRange = mainTextEditorTextView.selectedTextRange {
            
            if let newPosition = mainTextEditorTextView.position(from: selectedRange.start, offset: -1) {

                mainTextEditorTextView.selectedTextRange = mainTextEditorTextView.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    @objc fileprivate func cursorIsMovedToRight(sender: UIButton) {
        
        if let selectedRange = mainTextEditorTextView.selectedTextRange {
            
            if let newPosition = mainTextEditorTextView.position(from: selectedRange.start, offset: 1) {
                
                mainTextEditorTextView.selectedTextRange = mainTextEditorTextView.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    @objc fileprivate func allTextIsSelected(sender: UIButton) {
        
        mainTextEditorTextView.selectedTextRange = mainTextEditorTextView.textRange(from: mainTextEditorTextView.beginningOfDocument, to: mainTextEditorTextView.endOfDocument)
    }
    
    @objc fileprivate func cursorIsTabbed(sender: UIButton) {
        
        mainTextEditorTextView.insertText("    ")
    }
}
