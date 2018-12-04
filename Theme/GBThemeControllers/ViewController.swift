//
//  ViewController.swift
//  Theme
//
//  Created by Apple on 01/12/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchTheme: UISwitch!
    
    @IBOutlet weak var gbThemeView: GBThemeView!
    @IBOutlet weak var gbThemeButton: GBThemeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.switchTheme.isOn = GBTheme.theme.isNightMode
        self.gbThemeButton.layer.borderWidth = 2
    }
    
    @IBAction func btnSwitch(_ sender: Any?){
        if switchTheme.isOn{
            GBTheme.theme.isNightMode = true
        }else{
            GBTheme.theme.isNightMode = false
        }
    }
}

