//
//  TextEditorController+Extension.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/3/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

extension TextEditorController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        SyntaxHighlighService.shared.highlightText(for: "swift", in: textView)
    }
}

