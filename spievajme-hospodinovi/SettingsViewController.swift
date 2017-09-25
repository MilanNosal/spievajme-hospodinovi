//
//  SettingsViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 27/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

/*
 Velkost pisma
 
 Refreny osve
 Text deleny po versoch
 
 Farebna schema (zatial normal a nocna)
 
 */

class SettingsViewController: SHTableViewController {
    
    fileprivate let separateRefrainsCell = SeparateRefrainsCell()
    fileprivate let wrappedVersesCell = WrappedVersesCell()
    
    fileprivate let fontSizeCell = FontSizeCell()
    
    fileprivate let verseCell = VerseCell(style: .default, reuseIdentifier: nil)
    
    
    fileprivate let helpCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    fileprivate let infoCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    
    var exampleSong: Song! {
        didSet {
            currentSongModel = SongModel(song: exampleSong)
        }
    }
    fileprivate var currentSongModel: SongModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verseCell.selectionStyle = .none
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        self.title = "Nastavenia"
        
        helpCell.textLabel?.text = "Pomoc"
        helpCell.accessoryType = .disclosureIndicator
        helpCell.selectionStyle = .none
        helpCell.setupFontScheme()
        
        infoCell.textLabel?.text = "O aplikácii"
        infoCell.accessoryType = .disclosureIndicator
        infoCell.selectionStyle = .none
        infoCell.setupFontScheme()
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.leftBarButtonItem = resetButton
        
        let doneButton = UIBarButtonItem(title: "Hotovo", style: .plain, target: self, action: #selector(closeSelf))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Späť", style: .plain, target: nil, action: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 2
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                wrappedVersesCell.reload()
                return wrappedVersesCell
            }
            if indexPath.row == 1 {
                separateRefrainsCell.reload()
                return separateRefrainsCell
            }
            fatalError()
        case 1:
            if indexPath.row == 0 {
                fontSizeCell.reload()
                return fontSizeCell
            }
            if indexPath.row == 1 {
                currentSongModel = SongModel(song: exampleSong)
                verseCell.verse = currentSongModel.verses.first?.text
                verseCell.setupFontScheme()
                return verseCell
            }
            fatalError()
        case 2:
            
            if indexPath.row == 0 {
                return helpCell
            }
            if indexPath.row == 1 {
                return infoCell
            }
            fatalError()
            
        default:
            fatalError()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(HelpViewController(style: .grouped), animated: true)
                
            case 1:
                self.navigationController?.pushViewController(AboutViewController(style: .grouped), animated: true)
                
            default:
                fatalError()
            }
        }
    }
    
    @objc fileprivate func reset() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "Reset nastavení"
        alert.message = "Si si istý, že chceš nastavenia zresetovať do pôvodného stavu?"
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let resetAction = UIAlertAction(title: "Reset", style: .default, handler: { _ in
            
            Settings.setupNewFontScheme(of: CGFloat(18))
            UserDefaults.standard.refrainsWithVerses = false
            UserDefaults.standard.verseAsContinuousText = false
        })
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func closeSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func setupFontScheme() {
        super.setupFontScheme()
        separateRefrainsCell.setupFontScheme()
        wrappedVersesCell.setupFontScheme()
        fontSizeCell.setupFontScheme()
        helpCell.setupFontScheme()
        infoCell.setupFontScheme()
        verseCell.setupFontScheme()
        
        // update verse cell
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .none)
        tableView.endUpdates()
    }
    
    override func setupSettings() {
        super.setupSettings()
        tableView.reloadData()
    }
}

extension SettingsViewController {
    class SeparateRefrainsCell: UITableViewCell {
        static let identifier = "SettingsViewController.SeparateRefrainsCell"
        
        fileprivate let refrainSwitch = UISwitch()
        
        init() {
            super.init(style: .default, reuseIdentifier: nil)
            
            setupInitialHierarchy()
            setupInitialAttributes()
            setupInitialLayout()
        }
        
        private func setupInitialHierarchy() {
        }
        
        private func setupInitialAttributes() {
            textLabel?.text = "Samostatné refrény"
            
            refrainSwitch.isOn = !UserDefaults.standard.refrainsWithVerses
            refrainSwitch.addTarget(self, action: #selector(switchSwitched), for: .valueChanged)
            self.accessoryView = refrainSwitch
            
            self.selectionStyle = .none
        }
        
        @objc private func switchSwitched() {
            UserDefaults.standard.refrainsWithVerses = !refrainSwitch.isOn
            NotificationCenter.default.post(name: SHNotification.settingsChanged.notificationName, object: nil)
        }
        
        private func setupInitialLayout() {
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func reload() {
            refrainSwitch.isOn = !UserDefaults.standard.refrainsWithVerses
        }
        
    }
}

extension SettingsViewController {
    class WrappedVersesCell: UITableViewCell {
        static let identifier = "SettingsViewController.WrappedVersesCell"
        
        fileprivate let verseSwitch = UISwitch()
        
        init() {
            super.init(style: .default, reuseIdentifier: nil)
            
            setupInitialHierarchy()
            setupInitialAttributes()
            setupInitialLayout()
        }
        
        private func setupInitialHierarchy() {
        }
        
        private func setupInitialAttributes() {
            self.textLabel?.text = "Zalomené riadky vo veršoch"
            
            verseSwitch.isOn = !UserDefaults.standard.verseAsContinuousText
            verseSwitch.addTarget(self, action: #selector(switchSwitched), for: .valueChanged)
            self.accessoryView = verseSwitch
            
            self.selectionStyle = .none
        }
        
        @objc private func switchSwitched() {
            UserDefaults.standard.verseAsContinuousText = !verseSwitch.isOn
            NotificationCenter.default.post(name: SHNotification.settingsChanged.notificationName, object: nil)
        }
        
        private func setupInitialLayout() {
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func reload() {
            verseSwitch.isOn = !UserDefaults.standard.verseAsContinuousText
        }
        
    }
}

extension SettingsViewController {
    class FontSizeCell: UITableViewCell {
        static let identifier = "SettingsViewController.FontSizeCell"
        
        fileprivate let sizeSlider = UISlider()
        fileprivate let descLabel = UILabel()
        fileprivate let detailLabel = UILabel()
        
        fileprivate var _lastValue: Int = 0
        
        init() {
            super.init(style: .default, reuseIdentifier: nil)
            
            setupInitialHierarchy()
            setupInitialAttributes()
            setupInitialLayout()
        }
        
        private func setupInitialHierarchy() {
            contentView.addSubview(sizeSlider)
            contentView.addSubview(descLabel)
            contentView.addSubview(detailLabel)
        }
        
        private func setupInitialAttributes() {
            
            let currentValue = Int(round(UserDefaults.standard.fontSize))
            
            self.descLabel.text = "Veľkosť písma"
            self._lastValue = currentValue
            self.detailLabel.text = "\(currentValue)"
            self.detailLabel.textAlignment = .right
            
            
            sizeSlider.minimumValue = 12
            sizeSlider.maximumValue = 40
            sizeSlider.isContinuous = true
            sizeSlider.value = Float(currentValue)
            sizeSlider.addTarget(self, action: #selector(sliderChanged(slider:)), for: UIControlEvents.valueChanged)

            self.selectionStyle = .none
        }
        
        @objc private func sliderChanged(slider: UISlider) {
            let currentValue = Int(round(slider.value))
            slider.value = Float(currentValue)
            
            if _lastValue != currentValue {
                self.detailLabel.text = "\(currentValue)"
                _lastValue = currentValue
                Settings.setupNewFontScheme(of: CGFloat(currentValue))
            }
            
        }
        
        private func setupInitialLayout() {
            descLabel.translatesAutoresizingMaskIntoConstraints = false
            detailLabel.translatesAutoresizingMaskIntoConstraints = false
            sizeSlider.translatesAutoresizingMaskIntoConstraints = false
            [
                descLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor, constant: 0),
                descLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
                
                
                detailLabel.leftAnchor.constraint(equalTo: descLabel.rightAnchor, constant: 8),
                detailLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
                detailLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor, constant: 0),
                
                detailLabel.widthAnchor.constraint(equalTo: descLabel.widthAnchor, multiplier: 0.5),
                
                sizeSlider.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 12),
                sizeSlider.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor, constant: 0),
                sizeSlider.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor, constant: 0),
                sizeSlider.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8),
                
            ].activate()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func reload() {
            let currentValue = UserDefaults.standard.fontSize
            self._lastValue = Int(currentValue)
            self.detailLabel.text = "\(currentValue)"
            sizeSlider.value = Float(currentValue)
        }
        
    }
}




