//
//  VerseHeaderView.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class VerseHeaderView: UIView, FontSensitive {
    fileprivate let headerLabel = UILabel()
    
    var header: String = "" {
        didSet {
            self.headerLabel.text = header
        }
    }
    
    var isPortrait: Bool = false
    
    init() {
        super.init(frame: CGRect.zero)
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupInitialHierarchy() {
        self.addSubview(headerLabel)
    }
    
    fileprivate func setupInitialAttributes() {
        self.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
        headerLabel.font = Settings.currentFontScheme.verseTitleFont
        headerLabel.text = "NONE"
        headerLabel.textAlignment = .left
        headerLabel.numberOfLines = 0
    }
    
    fileprivate func setupInitialLayout() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.constraintsFittingToSuperview(topOffset: 4, leftOffset: 16, bottomOffset: 4, rightOffset: 16).activate()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        setupFontScheme()
    }
    
    func setupFontScheme() {
        if isPortrait {
            headerLabel.font = Settings.currentFontScheme.verseTitleFont
        } else {
            headerLabel.font = Settings.currentFontScheme.verseTitleFontLandscape
        }
    }
}
