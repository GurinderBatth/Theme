//
//  GBThemeButton.swift
//  Theme
//
//  Created by Apple on 02/12/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

class GBThemeButton: UIButton {

    private var defaultBackgroundColor: UIColor!
    private var defaultTextColor: UIColor!
    private var defaultBorderColor: UIColor?
    
    private var defaultImage: UIImage?
    private var defaultBackgroundImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultTextColor = self.currentTitleColor
        defaultBackgroundColor = self.backgroundColor ?? .clear
        defaultImage = self.currentImage
        defaultBackgroundImage = self.currentBackgroundImage
        self.setupNotifications()
        defer {
            self.isNightTheme = GBTheme.theme.isNightMode
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultTextColor = self.currentTitleColor
        defaultBackgroundColor = self.backgroundColor ?? .clear
        defaultImage = self.currentImage
        defaultBackgroundImage = self.currentBackgroundImage
        self.setupNotifications()
        defer {
            self.isNightTheme = GBTheme.theme.isNightMode
        }
    }
    
//MARK:-  Public Properties
    @IBInspectable var nightThemeBackgroundColor: UIColor? = .black{
        didSet{
            if isNightTheme{
                self.backgroundColor = nightThemeBackgroundColor
            }
        }
    }
    
    @IBInspectable var nightThemeTextColor: UIColor? = .white{
        didSet{
            if isNightTheme{
                self.setTitleColor(nightThemeTextColor, for: .normal)
            }
        }
    }
    
    @IBInspectable var nightThemeImage: UIImage?{
        didSet{
            if isNightTheme{
                if nightThemeImage != nil{
                    self.setImage(nightThemeImage, for: .normal)
                }else{
                    self.setImage(nightThemeImage, for: .normal)
                }
            }
        }
    }
    
    @IBInspectable var nightThemeBackgroundImage: UIImage?{
        didSet{
            if isNightTheme{
                if nightThemeBackgroundImage != nil{
                    self.setBackgroundImage(nightThemeBackgroundImage, for: .normal)
                }else{
                    self.setBackgroundImage(nightThemeBackgroundImage, for: .normal)
                }
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        didSet{
            self.defaultBorderColor  = borderColor
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var nightThemeBorderColor: UIColor?{
        didSet{
            if isNightTheme{
                self.layer.borderColor = nightThemeBorderColor?.cgColor
            }
        }
    }
    
//MARK:-  Private Functions
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
                self.setTitleColor(nightThemeTextColor ?? .white, for: .normal)
                if self.nightThemeBorderColor != nil{
                    self.layer.borderColor = self.nightThemeBorderColor?.cgColor
                }
                if self.currentImage != nil{
                    if self.nightThemeImage == nil{
                        self.setImage(defaultImage, for: .normal)
                    }else{
                        self.setImage(nightThemeImage, for: .normal)
                    }
                }
                if self.currentBackgroundImage != nil{
                    self.setBackgroundImage(nightThemeBackgroundImage, for: .normal)
                }
            }else{
                if self.nightThemeBorderColor != nil{
                    self.layer.borderColor = self.defaultBorderColor?.cgColor
                }
                self.backgroundColor = self.defaultBackgroundColor
                self.setTitleColor(self.defaultTextColor, for: .normal)
                if self.defaultImage != nil{
                    self.setImage(defaultImage, for: .normal)
                }
                if self.defaultBackgroundImage != nil{
                    self.setBackgroundImage(defaultBackgroundImage, for: .normal)
                }
            }
        }
    }
}
