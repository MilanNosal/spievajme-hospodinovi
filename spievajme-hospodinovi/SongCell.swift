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
    }
    
    fileprivate func setupInitialLayout() {
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [
            numberLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 4),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -4),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 4),
            numberLabel.widthAnchor.constraint(equalToConstant: 35),
            
            nameLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 8)
        ].activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
