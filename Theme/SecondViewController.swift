//
//  SecondViewController.swift
//  Theme
//
//  Created by Apple on 02/12/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var switchTheme: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchTheme.isOn = GBTheme.theme.isNightMode
    }
    
    @IBAction func btnSwitch(_ sender: Any?){
        if switchTheme.isOn{
            GBTheme.theme.isNightMode = true
        }else{
            GBTheme.theme.isNightMode = false
        }
    }
}
