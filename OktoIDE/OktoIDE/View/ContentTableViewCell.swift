//
//  ContentTableViewCell.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/22/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class ContentTableViewCell: UITableViewCell {
    
    static let id = "ContentTableViewCellID"
    let contentNameLabel = CustomLabel(fontSize: 20, text: "", textColor: ThemeService.shared.getMainColor(), textAlignment: .center, fontName: "Helvetica")
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(contentNameLabel)
        contentNameLabel.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
