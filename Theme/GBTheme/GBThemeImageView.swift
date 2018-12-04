//
//  GBThemeImageView.swift
//  Theme
//
//  Created by Apple on 04/12/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

class GBThemeImageView: UIImageView {
    
    private var defaultBackgroundColor: UIColor!
    private var defaultTextColor: UIColor!
    private var defaultBorderColor: UIColor?
    
    private var defaultImage: UIImage?
    private var defaultBackgroundImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultBackgroundColor = self.backgroundColor ?? .clear
        defaultImage = self.image
        self.setupNotifications()
        defer {
            self.isNightTheme = GBTheme.theme.isNightMode
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultBackgroundColor = self.backgroundColor ?? .clear
        defaultImage = self.image
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
    
    @IBInspectable var nightThemeImage: UIImage?{
        didSet{
            if isNightTheme{
                if nightThemeImage != nil{
                    self.image = nightThemeImage
                }else{
                    self.image = self.defaultImage
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
                if self.nightThemeBorderColor != nil{
                    self.layer.borderColor = self.nightThemeBorderColor?.cgColor
                }
                if self.nightThemeImage == nil{
                    self.image = defaultImage
                }else{
                    self.image = nightThemeImage
                }
            }else{
                if self.nightThemeBorderColor != nil{
                    self.layer.borderColor = self.defaultBorderColor?.cgColor
                }
                self.backgroundColor = self.defaultBackgroundColor
                if self.defaultImage != nil{
                    self.image = defaultImage
                }else{
                    self.image = nil
                }
            }
        }
    }
}
