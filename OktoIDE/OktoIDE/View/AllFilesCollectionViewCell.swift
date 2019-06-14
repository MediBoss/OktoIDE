//
//  AllFilesCollectionViewCell.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import SwipeCellKit
import UIKit

extension CALayer {
    
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil

            let contentLayer = CALayer()
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
    
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 0.2
        self.shadowRadius = 10
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
}

class AllFilesCollectionViewCell: SwipeCollectionViewCell {
    
    static let id = "AllFilesCollectionViewCellID"
    
    var file: File! {
        didSet{

            fileNameLabel.text = file.name
            editedLabel.text = "Last edited : \(file.editedAt ?? "")"
            languageColorView.backgroundColor = file.getLanguageAssociatedColor()
        }
    }
    
    lazy var fileNameLabel = CustomLabel(fontSize: 18,
                                         text: "NetworkManager.swift",
                                         textColor: ThemeService.shared.getMainColor(),
                                         textAlignment: .center,
                                         fontName: "Helvetica")
    
    lazy var editedLabel = CustomLabel(fontSize: 13,
                                       text: "Edited: 03.14.2019",
                                       textColor: .gray,
                                       textAlignment: .left,
                                       fontName: "Helvetica")
    
    lazy var languageColorView: UIView = {
       
        var view = UIView()
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if ThemeService.shared.isThemeDark(){
            self.backgroundColor = .lightDark
            self.fileNameLabel.textColor = .white
            self.editedLabel.textColor = .gray
        } else {
            self.backgroundColor = .lightGray
        }
        
        styleCell()
        constraintCellItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func styleCell() {
        
        self.layer.roundCorners(radius: 15)
        self.layer.addShadow()

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
