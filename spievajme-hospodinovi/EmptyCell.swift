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
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3).with(priority: UILayoutPriority.defaultHigh).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
