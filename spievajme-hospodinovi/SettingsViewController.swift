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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 35
        
        tableView.sectionHeaderHeight = 30
        
        self.title = "Nastavenia"
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.leftBarButtonItem = resetButton
        
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(closeSelf))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return aboutInfo[section].header
//    }
    
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
        default:
            fatalError()
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
        
        fileprivate let label = UILabel()
        fileprivate let refrainSwitch = UISwitch()
        
        init() {
            super.init(style: .default, reuseIdentifier: nil)
            
            setupInitialHierarchy()
            setupInitialAttributes()
            setupInitialLayout()
        }
        
        private func setupInitialHierarchy() {
            contentView.addSubview(label)
            contentView.addSubview(refrainSwitch)
        }
        
        private func setupInitialAttributes() {
            label.textAlignment = .left
            label.text = "Samostatné refrény"
            
            refrainSwitch.isOn = !UserDefaults.standard.refrainsWithVerses
            
            refrainSwitch.addTarget(self, action: #selector(switchSwitched), for: .valueChanged)
        }
        
        @objc private func switchSwitched() {
            UserDefaults.standard.refrainsWithVerses = !refrainSwitch.isOn
            NotificationCenter.default.post(name: SHNotification.settingsChanged.notificationName, object: nil)
        }
        
        private func setupInitialLayout() {
            label.translatesAutoresizingMaskIntoConstraints = false
            refrainSwitch.translatesAutoresizingMaskIntoConstraints = false
            [
                label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
                label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                
                refrainSwitch.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 4),
                
                refrainSwitch.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                refrainSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
                ].activate()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
}

extension SettingsViewController {
    class WrappedVersesCell: UITableViewCell {
        static let identifier = "SettingsViewController.WrappedVersesCell"
        
        fileprivate let label = UILabel()
        fileprivate let verseSwitch = UISwitch()
        
        init() {
            super.init(style: .default, reuseIdentifier: nil)
            
            setupInitialHierarchy()
            setupInitialAttributes()
            setupInitialLayout()
        }
        
        private func setupInitialHierarchy() {
            contentView.addSubview(label)
            contentView.addSubview(verseSwitch)
        }
        
        private func setupInitialAttributes() {
            label.textAlignment = .left
            label.text = "Zalomené riadky vo veršoch"
            
            verseSwitch.isOn = !UserDefaults.standard.verseAsContinuousText
            
            verseSwitch.addTarget(self, action: #selector(switchSwitched), for: .valueChanged)
        }
        
        @objc private func switchSwitched() {
            UserDefaults.standard.verseAsContinuousText = !verseSwitch.isOn
            NotificationCenter.default.post(name: SHNotification.settingsChanged.notificationName, object: nil)
        }
        
        private func setupInitialLayout() {
            label.translatesAutoresizingMaskIntoConstraints = false
            verseSwitch.translatesAutoresizingMaskIntoConstraints = false
            [
                label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
                label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                
                verseSwitch.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 4),
                
                verseSwitch.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                verseSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
                ].activate()
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




