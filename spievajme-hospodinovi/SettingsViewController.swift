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

class SettingsViewController: UITableViewController {
    
    fileprivate let separateRefrainsCell = SeparateRefrainsCell()
    fileprivate let wrappedVersesCell = WrappedVersesCell()
    
    fileprivate let infoCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    
    var exampleSong: Song! {
        didSet {
            currentSongModel = SongModel(song: exampleSong)
        }
    }
    fileprivate var currentSongModel: SongModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        self.title = "Nastavenia"
        
        infoCell.textLabel?.text = "O aplikácii"
        infoCell.accessoryType = .disclosureIndicator
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.leftBarButtonItem = resetButton
        
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(closeSelf))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return wrappedVersesCell
            }
            if indexPath.row == 1 {
                return separateRefrainsCell
            }
            fatalError()
        case 1:
            return infoCell
        default:
            fatalError()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(AboutViewController(style: .grouped), animated: true)
        }
    }
    
    @objc fileprivate func reset() {
        
    }
    
    @objc fileprivate func closeSelf() {
        self.dismiss(animated: true, completion: nil)
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
        
    }
}

extension UserDefaults {
    
    private static let refrainsWithVersesKey = "org.milan.nosal.refrainsWithVerses"
    
    var refrainsWithVerses: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaults.refrainsWithVersesKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.refrainsWithVersesKey)
        }
    }
    
    private static let verseAsContinuousTextKey = "org.milan.nosal.verseAsContinuousText"
    
    var verseAsContinuousText: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaults.verseAsContinuousTextKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.verseAsContinuousTextKey)
        }
    }
    
}




