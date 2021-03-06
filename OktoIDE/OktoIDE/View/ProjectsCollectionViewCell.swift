//
//  ProjectsCollectionViewCell.swift
//  OktoIDE
//
//  Created by Medi Assumani on 5/30/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class ProjectsCollectionViewCell: UICollectionViewCell {
    
    static let id = "AllFilesCollectionViewCellID"
    
    var project: Project! {
        didSet{

            projectNameLabel.text = project.name
            editedTimeLabel.text = "Last edited : \(project.updatedTime ?? "")"
            languageColorView.backgroundColor = project.getLanguageAssociatedColor()
        }
    }
    
    lazy var projectNameLabel = CustomLabel(fontSize: 18,
                                         text: "",
                                         textColor: ThemeService.shared.getMainColor(),
                                         textAlignment: .center,
                                         fontName: "Helvetica")
    
    lazy var editedTimeLabel = CustomLabel(fontSize: 13,
                                       text: "",
                                       textColor: .gray,
                                       textAlignment: .left,
                                       fontName: "Helvetica")
    
    //static let shared  = ProjectsCollectionViewCell()
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
        styleCell()
        constraintCellItems()
    }
    
    func checkTheme() {
        
        if ThemeService.shared.isThemeDark(){
            self.backgroundColor = .lightDark
            self.projectNameLabel.textColor = .white
            self.editedTimeLabel.textColor = .gray
        } else {
            self.backgroundColor = .lightGray
            self.projectNameLabel.textColor = ThemeService.shared.getMainColor()
            self.editedTimeLabel.textColor = .gray
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func styleCell() {
        
        self.layer.roundCorners(radius: 15)
        self.layer.addShadow()

    }
    
    fileprivate func constraintCellItems() {
        
        let labelStackView = CustomStackView(subviews: [projectNameLabel, editedTimeLabel],
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
