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
            verseLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
            verseLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -16),
            verseLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
            verseLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 2)
        ].activate()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc override func setupFontScheme() {
        super.setupFontScheme()
        let fontSize = Settings.currentFontScheme.verseTextFont
        verseLabel.font = fontSize
    }
}
