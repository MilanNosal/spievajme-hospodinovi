//
//  EmptyCell.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 25/09/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class EmptyCell: UITableViewCell {
    
    static let identifier = "EmptyCell"
    fileprivate let view = UIView()
    fileprivate var heightConstraint: NSLayoutConstraint!
    
    var isPortrait: Bool = false {
        didSet {
            if isPortrait {
                heightConstraint.constant = UIScreen.main.bounds.height / 4
            } else {
                heightConstraint.constant = 0
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
    }
    
    fileprivate func setupInitialHierarchy() {
        contentView.addSubview(view)
    }
    
    fileprivate func setupInitialAttributes() {
    }
    
    fileprivate func setupInitialLayout() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constraintsFittingToSuperview().activate()
        heightConstraint = view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4).with(priority: UILayoutPriority.defaultHigh)
        heightConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
