//
//  TextEditorController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import Prestyler
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
        
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "marker"), for: .normal)
        button.addTarget(self, action: #selector(allTextIsSelected(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var mainTextEditorTextView: UITextView = {
       
        let textEditor = UITextView()
        textEditor.backgroundColor = .white
        textEditor.textColor = .gloomyGreen
        textEditor.autocapitalizationType = .none
        textEditor.text = "// This is your text editor. Use it as a scratch pad"
        textEditor.enablesReturnKeyAutomatically = true
        textEditor.font = UIFont(name: "Helvetica", size: 20)

        return textEditor
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainTextEditorTextView)
        mainTextEditorTextView.fillSuperview()
        addAcessory()
        mainTextEditorTextView.delegate = self as? UITextViewDelegate
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

extension TextEditorController: UITextViewDelegate {
    
    

    func textViewDidChange(_ textView: UITextView) {

        guard let unwrappedText = textView.text else { return }
        Prestyler.defineRule("^", UIColor.swiftKeywordColorHighlight)

        let prefilteredText = unwrappedText.prefilter(text: "var", by: "^").prefilter(text: "let", by: "^").prefilter(text: "static", by: "^").prefilter(text: "for", by: "^").prefilter(text: "func", by: "^").prefilter(text: "while", by: "^").prefilter(text: "if", by: "^").prefilter(text: "return", by: "^").prefilter(text: "lazy", by: "^").prefilter(text: "super", by: "^").prefilter(text: "else", by: "^").prefilter(text: "class", by: "^").prefilter(text: "protocol", by: "^").prefilter(text: "struct", by: "^").prefilter(text: "continue", by: "^").prefilter(text: "case", by: "^").prefilter(text: "switch", by: "^").prefilter(text: "enum", by: "^").prefilter(text: "default", by: "^").prefilter(text: "defer", by: "^").prefilter(text: "guard", by: "^").prefilter(text: "throw", by: "^").prefilter(text: "try", by: "^").prefilter(text: "catch", by: "^").prefilter(text: "true", by: "^").prefilter(text: "false", by: "^").prefilter(text: "Self", by: "^").prefilter(text: "self", by: "^").prefilter(text: "Any", by: "^").prefilter(text: "get", by: "^").prefilter(text: "set", by: "^").prefilter(text: "override", by: "^").prefilter(text: "dynamic", by: "^").prefilter(text: "#selector", by: "^").prefilter(text: "weak", by: "^").prefilter(text: "unowned", by: "^").prefilter(text: "didSet", by: "^").prefilter(text: "willSet", by: "^").prefilter(text: "required", by: "^").prefilter(text: "convenience", by: "^").prefilter(text: "in", by: "^")
        
        textView.attributedText = prefilteredText.prestyled()
        textView.font = UIFont(name: "Helvetica", size: 20)
    }
}
