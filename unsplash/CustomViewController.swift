//
//  CustomNavigationController.swift
//  unsplash
//
//  Created by Hy Horng on 10/27/20.
//  Copyright © 2020 Hy Horng. All rights reserved.

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnLoginWasClicked(_ sender: Any) {
        UIApplication.shared.windows.first?.rootViewController = TabBarController()
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
