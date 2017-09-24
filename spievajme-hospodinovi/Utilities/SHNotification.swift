//
//  SHNotification.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 28/08/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import Foundation

enum SHNotification: String {
    
    case settingsChanged = "milan.nosal.SHSettingsChanged"
    case fontSchemeChanged = "milan.nosal.SHFontSchemeChanged"
    case colorSchemeChanged = "milan.nosal.SHColorSchemeChanged"
    
    var notificationName: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }
}
