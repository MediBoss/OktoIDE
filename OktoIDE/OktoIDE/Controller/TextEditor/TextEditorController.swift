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
    var editingFile: Content?
    
    lazy var textEditorkeyboardAccessory: UIView = {
        
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .lightGray
        accessoryView.alpha = 0.6
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        
        return accessoryView
    }()
    
    lazy var tabButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setTitle("tab", for: .normal)
        button.addTarget(self, action: #selector(cursorIsTabbed(sender:)), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var leftParentheseButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitle("(", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(leftParentheseButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var rightParentheseButton: UIButton = {
        
        let button = UIButton(type: .custom)

        button.setTitle(")", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(rightParentheseButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    lazy var leftBracketButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitle("{", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(leftBracketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var rightBracketButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitle("}", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(rightBracketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var colonButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitle(":", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(colonButtonTapped(sender:)), for: .touchUpInside)
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
    
    lazy var quoteButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitle(" \"\" ", for: .normal)
        button.addTarget(self, action: #selector(quoteButtonIsTapped(sender:)), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    lazy var mainTextEditorTextView: UITextView = {
       
        let textEditor = UITextView()
        
        //textEditor.font = UIFont(name: "<#T##String#>", size: <#T##CGFloat#>)
        textEditor.enablesReturnKeyAutomatically = false
        textEditor.autocapitalizationType = .none
        textEditor.autocorrectionType = .no
        textEditor.text = self.editingFile?.content?.decodeFromBase64()

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
        
    }
    
    //- MARK: CLASS METHODS
    
    /// Add a view on top of the text editor keyboard that will contain accessories.
    fileprivate func addAcessory() {
        
        textEditorkeyboardAccessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        mainTextEditorTextView.inputAccessoryView = textEditorkeyboardAccessory
        constraintAccessoryViewItems()
    }
    
    /// Horizontally stack up buttons to tab, highlight, and move the cursor on top of the keyboard
    fileprivate func constraintAccessoryViewItems() {
        
        let accessoryItemstackView = CustomStackView(subviews: [leftParentheseButton,
                                                                rightParentheseButton,
                                                                leftBracketButton,
                                                                rightBracketButton,
                                                                colonButton,
                                                                quoteButton,
                                                                tabButton,
                                                                highlightAllTextButton
                                                                ],
                                        alignment: .center,
                                        axis: .horizontal,
                                        distribution: .fillEqually)
        textEditorkeyboardAccessory.addSubview(accessoryItemstackView)
        accessoryItemstackView.fillSuperview()
    }
    
    ///
    @objc fileprivate func leftParentheseButtonTapped(sender: UIButton) {
        
        mainTextEditorTextView.insertText("(")
    }
    
    ///
    @objc fileprivate func rightParentheseButtonTapped(sender: UIButton) {
        
        mainTextEditorTextView.insertText(")")
    }
    
    @objc fileprivate func quoteButtonIsTapped(sender: UIButton) {
        
        mainTextEditorTextView.insertText("\"")
    }
    
    /// Highlight the entire text editor
    @objc fileprivate func allTextIsSelected(sender: UIButton) {
        
        mainTextEditorTextView.selectedTextRange = mainTextEditorTextView.textRange(from: mainTextEditorTextView.beginningOfDocument, to: mainTextEditorTextView.endOfDocument)
    }
    
    /// Moves the cursor to the right by 4 characters to mimick the tab key
    @objc fileprivate func cursorIsTabbed(sender: UIButton) {
        
        mainTextEditorTextView.insertText("    ")
    }
    
    @objc fileprivate func leftBracketButtonTapped(sender: UIButton){
        
        mainTextEditorTextView.insertText("{")
    }
    
    @objc fileprivate func rightBracketButtonTapped(sender: UIButton){
        
        mainTextEditorTextView.insertText("}")
    }
    
    @objc fileprivate func colonButtonTapped(sender: UIButton){
        
        mainTextEditorTextView.insertText(":")
    }
    
    @objc fileprivate func saveButtonIsTapped() {
        
        guard let file = editingFile, let sha = editingFile?.sha, let newContent = mainTextEditorTextView.text else { return }
        
        // Create an alert to show the user when saving their changes
        let commitChangeAlert = UIAlertController(title: "Commit changes", message: "provide a commit message and the branch to push to", preferredStyle: .alert)
        
        // Add two text fields for the user to enter the commit message and the branch to commit to
        commitChangeAlert.addTextField(configurationHandler: { commitMessageTextField in
            commitMessageTextField.placeholder = "Message"
        })
        
        commitChangeAlert.addTextField(configurationHandler: { commitBranchTextField in
            commitBranchTextField.placeholder = "Branch"
        })
        
        // Add two action to cancel the user's action or to push the changes
        commitChangeAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        commitChangeAlert.addAction(UIAlertAction(title: "Push", style: .default, handler: { [weak self] (_) in
            
            let commitMessage = commitChangeAlert.textFields![0].text ?? "default commit message"
            let branch = commitChangeAlert.textFields![1].text ?? "master"
            
            let encodedFileContent = newContent.encodeToBase64()
            let projectName = self?.editingFile?.repoName ?? ""
            let filename = self?.editingFile?.name ?? ""
            
            GithubService.shared.crudFileContent(operation: .update, route: .updateFile(projectName: projectName, fileName: filename), body: .updateFile(commitMessage: commitMessage, content: encodedFileContent, sha: sha, branch: branch), method: .put, completion: { (result) in
                
                switch result {
                case .success(_):
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(_):
                    print("failed to update file")
                }
            })
        }))
        
        self.present(commitChangeAlert, animated: true, completion: nil)
    }
    
    fileprivate func configureNavBar(){
        
        navigationItem.title = editingFile?.name ?? ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonIsTapped))
    }
}
