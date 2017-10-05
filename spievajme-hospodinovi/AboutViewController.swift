//
//  AboutViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 27/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class AboutViewController: SHTableViewController {
    
    fileprivate let aboutInfo: String = "<b><i>\"Spievajte Hospodinovi novú pieseň, chválospev o ňom v zhromaždení zbožných.\"</i></b> Žalm 149:1\n\n<br/><br/>Spievajme Hospodinovi je zbierka duchovných piesní pôvodne vydaná v knižnej podobe Cirkvou Adventistov Siedmeho Dňa roku 1995 v Martine. Táto voľne šíriteľná aplikácia predstavuje elektronickú verziu tohto spevníka.<br/><br/>Aplikácia bola vydaná s dovolením pôvodného vydavateľa."
    
    fileprivate let author: (key: String, value: String) = (key: "Kontakt", value: "milan.nosal@gmail.com")
    
    fileprivate let version: (key: String, value: String) = (key: "Verzia", value: "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) (\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String))")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        tableView.register(KeyValuePairCell.self, forCellReuseIdentifier: KeyValuePairCell.identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        tableView.allowsSelection = false
        
        self.title = "O aplikácii"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier) as! TextCell
            cell.content = aboutInfo
            return cell
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: KeyValuePairCell.identifier) as! KeyValuePairCell
                cell.content = author
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: KeyValuePairCell.identifier) as! KeyValuePairCell
                cell.content = version
                return cell
                
            default:
                fatalError()
            }
        default:
            fatalError()
        }
        
    }
    
    @objc fileprivate func closeSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AboutViewController {
    class HeaderView: UIView {
        fileprivate let headerLabel: UILabel = UILabel()
        
        var header: String {
            didSet {
                headerLabel.text = header
            }
        }
        
        init(header: String) {
            self.header = header
            super.init(frame: CGRect.zero)
            
            headerLabel.text = header
            self.addSubview(headerLabel)
            headerLabel.numberOfLines = 0
            headerLabel.textAlignment = .center
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            headerLabel.constraintsFittingToSuperview().activate()
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension AboutViewController {
    class TextCell: UITableViewCell {
        fileprivate static let identifier = "AboutViewController.TextCell"
        
        var content: String = "" {
            didSet {
                let enhancedString = "\(content)<style>body{font-family: '\(contentLabel.font.familyName)'; font-size:\(contentLabel.font.pointSize)px;}</style>"
                if let data = enhancedString.data(using: .unicode) {
                    do {
                        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html]
                        let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
                        contentLabel.attributedText = attributedString
                    } catch {
                        contentLabel.text = content
                    }
                } else {
                    contentLabel.text = content
                }
            }
        }
        
        fileprivate let contentLabel: UILabel = UILabel()
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(contentLabel)
            contentLabel.font = Settings.currentFontScheme.settingsSubtitleFont
            contentLabel.numberOfLines = 0
            contentLabel.translatesAutoresizingMaskIntoConstraints = false
            contentLabel.constraintsFittingToSuperview(topOffset: 12, leftOffset: 12, bottomOffset: 12, rightOffset: 12).activate()
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc override func setupFontScheme() {
            super.setupFontScheme()
            contentLabel.font = Settings.currentFontScheme.settingsSubtitleFont
            let contentText = self.content
            self.content = contentText
        }
    }
    
    class KeyValuePairCell: UITableViewCell {
        fileprivate static let identifier = "AboutViewController.KeyValuePairCell"
        
        var content: (key: String, value: String) = (key: "", value: "") {
            didSet {
                textLabel?.text = content.key
                detailTextLabel?.text = content.value
            }
        }
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
