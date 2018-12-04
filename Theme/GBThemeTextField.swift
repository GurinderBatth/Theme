//
//  GBThemeTextField.swift
//  Theme
//
//  Created by Apple on 02/12/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

class GBThemeTextField: UITextField {
    
    private var defaultBackgroundColor: UIColor!
    private var defaultTextColor: UIColor!
    private var defaultBorderColor: UIColor?
    
    private var defaultImage: UIImage?
    private var defaultBackgroundImage: UIImage?
    private var defaultRightImage: UIImage?
    private var defaultLeftImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultTextColor = self.textColor
        defaultBackgroundColor = self.backgroundColor ?? .clear
        self.setupNotifications()
        defer {
            self.isNightTheme = GBTheme.theme.isNightMode
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultTextColor = self.textColor
        defaultBackgroundColor = self.backgroundColor ?? .clear
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
                self.textColor = nightThemeTextColor
            }
        }
    }
    
    @IBInspectable var rightImage: UIImage?{
        didSet{
            self.defaultRightImage = rightImage
            self.setUpViewLeftRightView(rightImage, isLeftView: false)
        }
    }
    
    @IBInspectable var nightThemeRightImage: UIImage?{
        didSet{
            if isNightTheme{
                self.setUpViewLeftRightView(nightThemeRightImage, isLeftView: false)
            }
        }
    }
    
    @IBInspectable var leftImage: UIImage?{
        didSet{
            self.defaultLeftImage = leftImage
            self.setUpViewLeftRightView(leftImage, isLeftView: true)
        }
    }
    
    @IBInspectable var nightThemeLeftImage: UIImage?{
        didSet{
            if isNightTheme{
                self.setUpViewLeftRightView(nightThemeLeftImage, isLeftView: true)
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
                self.textColor = nightThemeTextColor
                if self.nightThemeBorderColor != nil{
                    self.layer.borderColor = self.nightThemeBorderColor?.cgColor
                }
                
                if nightThemeRightImage != nil{
                    if let rightViewLocal = self.rightView{
                        self.changeImage(rightViewLocal, nightThemeRightImage)
                    }
                }
                
                if nightThemeLeftImage != nil{
                    if let leftViewLocal = self.leftView{
                        self.changeImage(leftViewLocal, nightThemeLeftImage)
                    }
                }
                
            }else{
                self.rightImage = self.defaultRightImage
                self.leftImage = self.defaultLeftImage
                
                if self.nightThemeBorderColor != nil{
                    self.layer.borderColor = self.defaultBorderColor?.cgColor
                }
                self.backgroundColor = self.defaultBackgroundColor
                self.textColor = self.defaultTextColor
            }
        }
    }

    private func setUpViewLeftRightView(_ image: UIImage?, isLeftView: Bool){
        let textLeftView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        let imageView = UIImageView(image: image)
        textLeftView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLeftView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: [:], views: ["v0":imageView]))
        textLeftView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: [:], views: ["v0":imageView]))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        if isLeftView{
            self.leftView = textLeftView
            self.leftViewMode = .always
        }else{
            self.rightView = textLeftView
            self.rightViewMode = .always
        }
    }
    
    private func changeImage(_ viewsetUp:  UIView,_ image: UIImage?){
        for view in viewsetUp.subviews{
            if view is UIImageView{
                (view as! UIImageView).image = image
                break
            }
        }
    }
}
