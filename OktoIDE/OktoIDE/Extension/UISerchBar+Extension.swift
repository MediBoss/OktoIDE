//
//  UISerchBar+Extension.swift
//  OktoIDE
//
//  Created by Medi Assumani on 7/6/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}

extension UITextField {
    
    func setPadding() {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setBottomBorder() {
        
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
