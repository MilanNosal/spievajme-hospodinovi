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
        self.backgroundColor = UIColor.lightGray
        headerLabel.font = Settings.currentFontScheme.verseTitleFont
        headerLabel.text = "NONE"
        headerLabel.textAlignment = .left
        headerLabel.numberOfLines = 0
    }
    
    fileprivate func setupInitialLayout() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.constraintsFittingToSuperview(topOffset: 12, leftOffset: 12, bottomOffset: 8, rightOffset: 8).activate()
    }
    
    func setupFontScheme() {
        headerLabel.font = Settings.currentFontScheme.verseTitleFont
    }
}
