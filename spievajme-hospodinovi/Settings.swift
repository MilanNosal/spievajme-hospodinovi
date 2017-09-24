//
//  Settings.swift
//  spievajme-hospodinovi
//
//  Created by Milan Nosáľ on 02/09/2017.
//  Copyright © 2017 Svagant. All rights reserved.
//

import UIKit

struct ColorScheme {
    
}

class FontScheme {
    var verseTextFont: UIFont?
    var verseTextFontLandscape: UIFont?
    var verseTitleFont: UIFont?
    var verseTitleFontLandscape: UIFont?
    var navigationItemTitleFont: UIFont?
    var navigationItemButtonFont: UIFont?
    var songNumberFont: UIFont?
    var songTitleFont: UIFont?
    var settingsTitleFont: UIFont?
    var settingsSubtitleFont: UIFont?
}

class Settings {
    
    static var currentFontScheme: FontScheme = loadFontScheme()
    
    static func setupNewFontScheme(of size: CGFloat) {
        currentFontScheme = getFontScheme(for: size)
        UserDefaults.standard.fontSize = Double(size)
    }
    
    static func loadFontScheme() -> FontScheme {
        return getFontScheme(for: CGFloat(UserDefaults.standard.fontSize))
    }
    
    fileprivate static func getFontScheme(for size: CGFloat) -> FontScheme {
        let scheme = FontScheme()
        scheme.verseTextFont = UIFont.systemFont(ofSize: size)
        scheme.verseTextFontLandscape = UIFont.systemFont(ofSize: size + 10)
        scheme.verseTitleFont = UIFont.boldSystemFont(ofSize: size)
        scheme.verseTitleFontLandscape = UIFont.boldSystemFont(ofSize: size + 10)
        scheme.navigationItemTitleFont = UIFont.boldSystemFont(ofSize: size)
        scheme.navigationItemButtonFont = UIFont.systemFont(ofSize: size)
        scheme.songNumberFont = UIFont.boldSystemFont(ofSize: size)
        scheme.songTitleFont = UIFont.systemFont(ofSize: size)
        scheme.settingsTitleFont = UIFont.systemFont(ofSize: size)
        scheme.settingsSubtitleFont = UIFont.systemFont(ofSize: size)
        return scheme
    }
}


extension UserDefaults {
    
    private static let fontSizeKey = "org.milan.nosal.fontSize"
    
    var fontSize: Double {
        get {
            let result = UserDefaults.standard.double(forKey: UserDefaults.fontSizeKey)
            if result <= 0 {
                let defaultVal = Double(18)
                UserDefaults.standard.set(defaultVal, forKey: UserDefaults.fontSizeKey)
                return defaultVal
            } else {
                return result
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.fontSizeKey)
            
            NotificationCenter.default.post(name: SHNotification.fontSchemeChanged.notificationName, object: nil)
        }
    }
    
    private static let refrainsWithVersesKey = "org.milan.nosal.refrainsWithVerses"
    
    var refrainsWithVerses: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaults.refrainsWithVersesKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.refrainsWithVersesKey)
            NotificationCenter.default.post(name: SHNotification.settingsChanged.notificationName, object: nil)
        }
    }
    
    private static let verseAsContinuousTextKey = "org.milan.nosal.verseAsContinuousText"
    
    var verseAsContinuousText: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaults.verseAsContinuousTextKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.verseAsContinuousTextKey)
            NotificationCenter.default.post(name: SHNotification.settingsChanged.notificationName, object: nil)
        }
    }
    
}
