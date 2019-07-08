//
//  OnboardingController.swift
//  OktoIDE
//
//  Created by Medi Assumani on 7/6/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    private let onboardingView = PaperOnboarding()
    private let pagerIcon = UIImage(named: "pager")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.dataSource = self
        onboardingView.delegate = self
        mainAutoLayout()
    }
    
    let getStartedButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("GET STARTED", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleGetStartedButton(_:)), for: .touchUpInside)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    /// Skips to show the user a page to select their preferences
    @objc private func handleGetStartedButton(_ sender: UIButton){
        
        sender.pulsate()
        self.present(LoginViewController(), animated: true, completion: nil)
    }
    
    
    /// Makes sure the `GET STARTED` button is hidden until the last page
    func onboardingWillTransitonToIndex(_ index: Int) {
        
        if index == 3 {
            
            if self.getStartedButton.alpha == 3 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButton.alpha = 0
                })
            }
            
        }
    }
    
    /// Animates the `GET STARTED` button to appear when on last page
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 4 {
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
    }
    
    /// Lays out the onboarding view and `GET STARTED` button
    private func mainAutoLayout(){
        
        view.addSubview(onboardingView)
        view.addSubview(getStartedButton)
        onboardingView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, topPadding: 0, rightPadding: 0, bottomPadding: 0, leftPadding: 0, height: 0, width: 0)
        
        NSLayoutConstraint.activate([
            getStartedButton.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.width/3))
            ])
    }
    
    /// The number of pages for the onboarding
    func onboardingItemsCount() -> Int {
        return 5
    }
    
    /// Sets up the pages that will be displayed during onboarding
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descirptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        
        return [ OnboardingItemInfo(informationImage: UIImage(named: "logo")!,
                               title: "Welcome to OktoIDE",
                               description: "OktoIDE is your on-the-go text editor to work on your code when away from your workstation.",
                               pageIcon: pagerIcon!,
                               color: .black,
                               titleColor: .white,
                               descriptionColor: .white,
                               titleFont: titleFont,
                               descriptionFont: descirptionFont),
                 
                 OnboardingItemInfo(informationImage: UIImage(named: "synchronization")!,
                                    title: "Sync your Github",
                                    description: "Access, commit, and push code to Github from your mobile device.",
                                    pageIcon: pagerIcon!,
                                    color: .grayIsh,
                                    titleColor: .black,
                                    descriptionColor: .black,
                                    titleFont: titleFont,
                                    descriptionFont: descirptionFont),
                 
                 OnboardingItemInfo(informationImage: UIImage(named: "highlighter")!,
                                    title: "Syntax highlight",
                                    description: "OktoIDE supports syntax highlight for Swift, Python, Javascript, and more to come.",
                                    pageIcon: pagerIcon!,
                                    color: .cyanGreen,
                                    titleColor: .white,
                                    descriptionColor: .white,
                                    titleFont: titleFont,
                                    descriptionFont: descirptionFont),
                 
                 OnboardingItemInfo(informationImage: UIImage(named: "keyboard")!,
                                    title: "Keyboard Accessiblity",
                                    description: "OktoIDE provides your keyboard with shortcuts and utilities to speed up and ease your coding sessions.",
                                    pageIcon: pagerIcon!,
                                    color: .lightPink,
                                    titleColor: .white,
                                    descriptionColor: .white,
                                    titleFont: titleFont,
                                    descriptionFont: descirptionFont),
                 
                 OnboardingItemInfo(informationImage: UIImage(named: "settings")!,
                                    title: "Dark & Light Themes",
                                    description: "OktoIDE supports light and dark theme to help to your visual preferences.",
                                    pageIcon: pagerIcon!,
                                    color: .grayIsh,
                                    titleColor: .black,
                                    descriptionColor: .black,
                                    titleFont: titleFont,
                                    descriptionFont: descirptionFont)
            
            ][index] as OnboardingItemInfo
    }
}
