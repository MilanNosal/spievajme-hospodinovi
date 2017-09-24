//
//  SHViewController.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 03/09/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

class SHViewController: UIViewController, FontSensitive {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiveSHNotification(notification:)),
                                               name: SHNotification.settingsChanged.notificationName,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiveSHNotification(notification:)),
                                               name: SHNotification.fontSchemeChanged.notificationName,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiveSHNotification(notification:)),
                                               name: SHNotification.colorSchemeChanged.notificationName,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func receiveSHNotification(notification: NSNotification) {
        DispatchQueue.main.async {
            switch SHNotification(rawValue: notification.name.rawValue)! {
            case .settingsChanged:
                self.setupSettings()
                
            case .fontSchemeChanged:
                self.setupFontScheme()
                
            case .colorSchemeChanged:
                self.setupColorScheme()
                
            }
        }
    }
    
    func setupSettings() {
        
    }
    
    func setupFontScheme() {
        
    }
    
    func setupColorScheme() {
        
    }
}
