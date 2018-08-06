//
//  SecondViewController.swift
//  Runner
//
//  Created by Chetan Bhalerao on 7/30/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        
    }
    func setUpNavBar(){
        self.navigationItem.title = "IOS component"
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.done, target: self, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(red:  34/255.0, green: 149/255.0, blue: 243/255.0, alpha: 100.0/100.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = self.uicolorFromHex(rgbValue: 0xffffff)
        // change navigation item title color
        
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
