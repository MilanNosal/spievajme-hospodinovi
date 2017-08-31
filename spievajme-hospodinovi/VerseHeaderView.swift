//
//  VerseHeaderView.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 30/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class VerseHeaderView: UIView {
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
        headerLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        headerLabel.text = "NONE"
        headerLabel.textAlignment = .left
        headerLabel.numberOfLines = 0
    }
    
    fileprivate func setupInitialLayout() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
//        headerLabel.constraintsFittingToSuperview(topOffset: 12, leftOffset: 12, bottomOffset: 8, rightOffset: 8).activate()
        [
            headerLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 0),
            headerLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 0),
            headerLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 0),
            headerLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 2)
            ].activate()
    }
}
