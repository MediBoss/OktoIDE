//
//  SyntaxHighlightService.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import Prestyler
import UIKit

class SyntaxHighlighService {
    
    // - MARK : CLASS INSTANCES
    static let shared = SyntaxHighlighService()
    
    static let languageWithHighlight = ["swift", "python", "javascript", "go"]
    
    static let languageColorDict = ["swift": UIColor.swiftGithubRepoColor,
                                    "py": UIColor.pythonKeywordColorHighlight,
                                    "js": UIColor.javascriptKeywordColorHighlight,
                                    "go": UIColor.goKeywordColorHighlight]
    
    // MARK : CLASS METHODS
    func highlightText(for language: String, in textView: UITextView) {
        
        guard let unwrappedText = textView.text else { return }
       
        Prestyler.defineRule("^", UIColor.swiftKeywordColorHighlight)
        
        let prefilteredText = unwrappedText.prefilter(text: "var", by: "^").prefilter(text: "let", by: "^").prefilter(text: "static", by: "^").prefilter(text: "init", by: "^").prefilter(text: "for", by: "^").prefilter(text: "func", by: "^").prefilter(text: "while", by: "^").prefilter(text: "if", by: "^").prefilter(text: "return", by: "^").prefilter(text: "lazy", by: "^").prefilter(text: "super", by: "^").prefilter(text: "else", by: "^").prefilter(text: "class", by: "^").prefilter(text: "protocol", by: "^").prefilter(text: "struct", by: "^").prefilter(text: "continue", by: "^").prefilter(text: "case", by: "^").prefilter(text: "switch", by: "^").prefilter(text: "enum", by: "^").prefilter(text: "default", by: "^").prefilter(text: "defer", by: "^").prefilter(text: "guard", by: "^").prefilter(text: "throw", by: "^").prefilter(text: "try", by: "^").prefilter(text: "catch", by: "^").prefilter(text: "true", by: "^").prefilter(text: "false", by: "^").prefilter(text: "Self", by: "^").prefilter(text: "self", by: "^").prefilter(text: "Any", by: "^").prefilter(text: "get", by: "^").prefilter(text: "set", by: "^").prefilter(text: "override", by: "^").prefilter(text: "dynamic", by: "^").prefilter(text: "#selector", by: "^").prefilter(text: "weak", by: "^").prefilter(text: "unowned", by: "^").prefilter(text: "didSet", by: "^").prefilter(text: "willSet", by: "^").prefilter(text: "required", by: "^").prefilter(text: "convenience", by: "^").prefilter(text: "import", by: "^").prefilter(text: "final", by: "^").prefilter(text: "#selector", by: "^").prefilter(text: "@objc", by: "^").prefilter(text: "extension", by: "^").prefilter(text: "@IBOutlet", by: "^").prefilter(text: "@IBAction", by: "^").prefilter(text: "@IBDesignable", by: "^").prefilter(text: "@escaping", by: "^").prefilter(text: "public", by: "^").prefilter(text: "private", by: "^").prefilter(text: "fileprivate", by: "^").prefilter(text: "internal", by: "^").prefilter(text: "typealias", by: "^")
        
        textView.attributedText = prefilteredText.prestyled()
        textView.font = UIFont(name: "Helvetica", size: 20)
    }
}