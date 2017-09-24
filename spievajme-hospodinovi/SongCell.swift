//
//  SongCell.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 26/07/16.
//  Copyright © 2016 Svagant. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    static let identifier = "SongCell"
    
    private let numberLabel: UILabel = UILabel()
    private let nameLabel: UILabel = UILabel()
    
    var song: Song! {
        didSet {
            numberLabel.text = String(song.number)
            nameLabel.text = song.title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupInitialHierarchy()
        setupInitialAttributes()
        setupInitialLayout()
    }
    
    fileprivate func setupInitialHierarchy() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
    }
    
    fileprivate func setupInitialAttributes() {
        numberLabel.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)
        numberLabel.textColor = UIColor.darkGray
        numberLabel.text = "0"
        numberLabel.textAlignment = .right
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        nameLabel.text = "NONE"
        nameLabel.textAlignment = .left
        
        setupFontScheme()
    }
    
    fileprivate func setupInitialLayout() {
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [
            numberLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 4),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -4),
            numberLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor, constant: 4),
            numberLabel.widthAnchor.constraint(equalToConstant: 35),
            
            nameLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor, constant: -4)
        ].activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc override func setupFontScheme() {
        numberLabel.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)
        nameLabel.textAlignment = .left
    }
}
