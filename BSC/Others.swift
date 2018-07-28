//
//  Others.swift
//  BSC
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import UIKit

extension Locale {
    static var preferredLanguage: String {
        get {
            return self.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
}

extension String {
    var localized: String {
        
        var result: String
        
        let languageCode = Locale.preferredLanguage //en-US
        
        var path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        
        if path == nil, let hyphenRange = languageCode.range(of: "-") {
            let languageCodeShort = String(languageCode[..<hyphenRange.lowerBound])
            path = Bundle.main.path(forResource: languageCodeShort, ofType: "lproj")
        }
        
        if let path = path, let locBundle = Bundle(path: path) {
            result = locBundle.localizedString(forKey: self, value: nil, table: nil)
        } else {
            result = NSLocalizedString(self, comment: "")
        }
        return result
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
