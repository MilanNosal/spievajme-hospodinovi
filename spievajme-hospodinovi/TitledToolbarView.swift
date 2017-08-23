//
//  TitledToolbarView.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 21/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class TitledToolbarView: UIView {
    
    fileprivate let iconView = UIImageView()
    fileprivate let titleLabel = UILabel()
    
    var icon: UIImage = UIImage() {
        didSet {
            iconView.image = icon
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
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
        self.addSubview(iconView)
        self.addSubview(titleLabel)
    }
    
    fileprivate func setupInitialAttributes() {
        iconView.contentMode = .scaleAspectFit
        
        titleLabel.font = titleLabel.font.withSize(12)
    }
    
    fileprivate func setupInitialLayout() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 35),
            
            iconView.topAnchor.constraint(equalTo: self.topAnchor),
            iconView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            iconView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
            
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).with(priority: UILayoutPriority(rawValue: 999)),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).with(priority: UILayoutPriority(rawValue: 999)),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ].activate()
    }
    
}
