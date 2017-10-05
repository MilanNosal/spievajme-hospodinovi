//
//  HelpViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 25/09/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class HelpViewController: UITableViewController {
    
    fileprivate let iconDescriptions: [IconControlHelpCell] = [
        IconControlHelpCell(icon: #imageLiteral(resourceName: "navigation_settingsEmpty"), comment: "Tlačidlo otvorí nastavenia aplikácie."),
        IconControlHelpCell(icon: #imageLiteral(resourceName: "toolbar_fullHeart"), comment: "Vyplnené srdce pri obrazovke s piesňou označuje obľúbenú pieseň. V hlavnej obrazovke indikuje zapnutý filter obľúbených piesní - pri zapnutí tohto filtra sú zobrazené iba piesne, ktoré si označil za svoje obľúbené."),
        IconControlHelpCell(icon: #imageLiteral(resourceName: "toolbar_emptyHeart"), comment: "Jeho stlačenie v obrazovke s piesňou danú pieseň označí ako obľúbenú. V hlavnej obrazovke indikuje vypnutý filter obľúbených piesní."),
        IconControlHelpCell(icon: #imageLiteral(resourceName: "toolbar_searchThiner"), comment: "Tlačidlo slúži ako skratka do políčka 'Hľadať' v hlavnej obrazovke. Slúži ako filter piesní podľa zadaného textu. Pomocou tohto nástroja si môžeš nájsť pieseň podľa jej textu."),
        IconControlHelpCell(icon: #imageLiteral(resourceName: "toolbar_numpadEmpty"), comment: "Ikona číselnej klávesnice slúži na rýchlu navigáciu na konkrétnu pieseň. Jej stlačenie ti otvorí dialógové okno, do ktorého môžeš zadať číslo piesne a priamo ju otvoriť."),
        IconControlHelpCell(icon: #imageLiteral(resourceName: "toolbar_lastSong"), comment: "Tlačidlo 'Späť' ti otvorí posledne otvorenú pieseň."),
    ]
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        tableView.allowsSelection = false
        
        self.title = "Pomoc"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconDescriptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return iconDescriptions[indexPath.row]
    }
}

extension HelpViewController {
    class IconControlHelpCell: UITableViewCell {
        
        static let identifier = "HelpViewController.IconControlHelpCell"
        
        fileprivate let iconView = UIImageView()
        fileprivate let descriptionLabel = UILabel()
        
        fileprivate let comment: String
        fileprivate let icon: UIImage
        
        init(icon: UIImage, comment: String) {
            self.icon = icon
            self.comment = comment
            
            super.init(style: .default, reuseIdentifier: nil)
            
            setupInitialHierarchy()
            setupInitialAttributes()
            setupInitialLayout()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        fileprivate func setupInitialHierarchy() {
            self.contentView.addSubview(iconView)
            self.contentView.addSubview(descriptionLabel)
        }
        
        fileprivate func setupInitialAttributes() {
            iconView.contentMode = .scaleAspectFit
            iconView.image = icon
            
            descriptionLabel.numberOfLines = 0
            setupFontScheme()
            descriptionLabel.text = comment
        }
        
        fileprivate func setupInitialLayout() {
            iconView.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            [
                iconView.heightAnchor.constraint(equalToConstant: 40),
                iconView.widthAnchor.constraint(equalToConstant: 40),
                iconView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor, constant: 0),
                iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).with(priority: UILayoutPriority(rawValue: 150)),
                
                descriptionLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 16),
                descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
                descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            ].activate()
        }
        
        @objc override func setupFontScheme() {
            super.setupFontScheme()
            
            descriptionLabel.font = Settings.currentFontScheme.settingsSubtitleFont
        }
    }
}
