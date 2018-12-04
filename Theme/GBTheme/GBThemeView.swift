//
//  GBThemeView.swift
//  Theme
//
//  Created by Apple on 02/12/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

@IBDesignable
class GBThemeView: UIView {
    
    private var defaultColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultColor = self.backgroundColor ?? .white
        self.setupNotifications()
        self.isNightTheme = false
        defer {
            self.isNightTheme = GBTheme.theme.isNightMode
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultColor = self.backgroundColor ?? .white
        self.setupNotifications()
        self.isNightTheme = false
        defer {
            self.isNightTheme = GBTheme.theme.isNightMode
        }
    }
    
    private func setupNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(lightMode), name: .lightMode, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nightMode), name: .nightMode, object: nil)
    }
    
    @objc private func lightMode(){
        self.isNightTheme = false
    }
    
    @objc private func nightMode(){
        self.isNightTheme = true
    }
    
    private var isNightTheme: Bool = false{
        didSet{
            if isNightTheme{
                self.backgroundColor = nightThemeBackgroundColor ?? .black
            }else{
                self.backgroundColor = self.defaultColor
            }
        }
    }
    
    @IBInspectable var nightThemeBackgroundColor: UIColor? = .black{
        didSet{
            if isNightTheme{
                self.backgroundColor = nightThemeBackgroundColor
            }
        }
    }
}
