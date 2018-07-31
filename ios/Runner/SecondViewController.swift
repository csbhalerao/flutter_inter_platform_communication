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
        UIView.animate(withDuration: 0.5) {
            self.navigationController?.isNavigationBarHidden = false
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
