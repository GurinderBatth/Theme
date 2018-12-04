//
//  GBTheme.swift
//  Theme
//
//  Created by Apple on 02/12/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import Foundation

class GBTheme {
    
    static var theme = GBTheme()
    
    var isNightMode: Bool{
        set{
            if newValue{
                NotificationCenter.default.post(name: .nightMode, object: nil)
            }else{
                NotificationCenter.default.post(name: .lightMode, object: nil)
            }
            UserDefaults.standard.set(newValue, forKey: "isNighMode")
        }get{
            return UserDefaults.standard.value(forKey: "isNighMode") as? Bool ?? false
        }
    }
}

extension Notification.Name{
    public static let nightMode = NSNotification.Name("nighMode")
    public static let lightMode = NSNotification.Name("lightMode")
}

