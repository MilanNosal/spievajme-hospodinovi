//
//  VerseCell.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 27/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class VerseCell: UITableViewCell {
    
    static let identifier = "VerseCell"
    
    private let verseLabel: UILabel = UILabel()
    
    var verse: String! {
        didSet {
            verseLabel.text = verse
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
    }
    
    fileprivate func setupInitialHierarchy() {
        contentView.addSubview(verseLabel)
    }
    
    fileprivate func setupInitialAttributes() {
        verseLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        verseLabel.text = "NONE"
        verseLabel.textAlignment = .left
        verseLabel.numberOfLines = 0
        setupFontScheme()
    }
    
    fileprivate func setupInitialLayout() {
        verseLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            verseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            verseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            verseLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            verseLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ].activate()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        setupFontScheme()
    }
    
    @objc override func setupFontScheme() {
        super.setupFontScheme()
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            verseLabel.font = Settings.currentFontScheme.verseTextFontLandscape
        } else {
            verseLabel.font = Settings.currentFontScheme.verseTextFont
        }
    }
}
