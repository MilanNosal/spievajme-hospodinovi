//
//  AboutViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 27/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {
    
    fileprivate let aboutInfo: [(header: HeaderView, text: String)] = [
        (header: HeaderView(header: ""), text: "<b><i>\"Spievajte Hospodinovi novú pieseň, chválospev o ňom v zhromaždení zbožných.\"</i></b> Žalm 149:1\n\n<br/><br/>Spievajme Hospodinovi je zbierka duchovných piesní pôvodne vydaná v knižnej podobe Cirkvou Adventistov Siedmeho Dňa roku 1995 v Martine. Táto voľne šíriteľná aplikácia predstavuje elektronickú verziu tohto spevníka.<br/><br/>Aplikácia bola vydaná s dovolením pôvodného vydavateľa."),
        (header: HeaderView(header: "Autor"), text: "Milan Nosáľ"),
        (header: HeaderView(header: "Verzia"), text: "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        tableView.sectionHeaderHeight = 30
        
        self.title = "O aplikácii"
        
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(closeSelf))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return aboutInfo.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return aboutInfo[section].header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier) as! TextCell
        cell.content = aboutInfo[indexPath.section].text
        return cell
        
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
            contentLabel.numberOfLines = 0
            contentLabel.translatesAutoresizingMaskIntoConstraints = false
            contentLabel.constraintsFittingToSuperview(topOffset: 12, leftOffset: 12, bottomOffset: 12, rightOffset: 12).activate()
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
