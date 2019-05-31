//
//  AllFilesCollectionViewCell.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class AllFilesCollectionViewCell: UICollectionViewCell {
    
    static let id = "AllFilesCollectionViewCellID"
    
    var file: File! {
        didSet{
            
            fileNameLabel.text = file.name
            editedLabel.text = "Edited : \(file.editTimeStamp)"
            languageColorView.backgroundColor = file.getLanguageAssociatedColor()
        }
    }
    
    lazy var fileNameLabel = CustomLabel(fontSize: 20,
                                         text: "NetworkManager.swift",
                                         textColor: .black,
                                         textAlignment: .center,
                                         fontName: "Helvetica")
    
    lazy var editedLabel = CustomLabel(fontSize: 15,
                                       text: "Edited: 03.14.2019",
                                       textColor: .black,
                                       textAlignment: .left,
                                       fontName: "Helvetica")
    
    lazy var languageColorView: UIView = {
       
        var view = UIView()
        view.backgroundColor = .swiftKeywordColorHighlight
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        styleCell()
        constraintCellItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func styleCell() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 1
    }
    fileprivate func constraintCellItems() {
        
        let labelStackView = CustomStackView(subviews: [fileNameLabel, editedLabel],
                                             alignment: .leading,
                                             axis: .vertical,
                                             distribution: .fillEqually)
        
        let mainCellStackView = CustomStackView(subviews: [labelStackView, languageColorView],
                                                alignment: .center,
                                                axis: .horizontal,
                                                distribution: .fill)
        
        addSubview(mainCellStackView)
        mainCellStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
}
