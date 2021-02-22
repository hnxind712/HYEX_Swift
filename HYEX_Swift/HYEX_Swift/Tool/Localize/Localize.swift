//
//  Localize.swift
//
//  Created by natai on 2020/4/8.
//  
//  Copyright © 2020 bibr. All rights reserved.
//
    

import Foundation

let LCLLanguageChangeNotification = "LCLLanguageChangeNotification"
let LCLBaseBundle = "Base"

extension String {
    func localizedFormat(_ args: CVarArg...) -> String {
        return String.init(format: self, arguments: args)
    }
}

extension Bundle {
    static var localized: Bundle {
        let main = Bundle.main
        if let path = main.path(forResource: Localize.currentLanguage(), ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle
        } else if let path = main.path(forResource: LCLBaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle
        } else {    // 主 bundle 若没有当前语言 bundle
            return main
        }
    }
}

class Localize : NSObject {
    static func availableLanguages(_ excludeBase: Bool = true) -> [String] {
        var availableLanguages = Bundle.main.localizations
        if let indexOfBase = availableLanguages.firstIndex(of: "Base") , excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
static func currentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: "LCLCurrentLanguageKey") as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }
    
    static func defaultLanguage() -> String {
        let LCLDefaultLanguage = "en"
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = LCLDefaultLanguage
        }
        return defaultLanguage
    }
    
   static func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if selectedLanguage != currentLanguage() {
            UserDefaults.standard.set(selectedLanguage, forKey: "LCLCurrentLanguageKey")
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
        }
    }
    
    static func displayNameForLanguage(_ language: String) -> String {
        let locale: NSLocale = NSLocale(localeIdentifier: language)
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}
