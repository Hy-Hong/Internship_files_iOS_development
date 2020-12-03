//
//  DopeTabBarController.swift
//  customTabBarController
//
//  Created by Hy Horng on 9/24/20.
//  Copyright © 2020 Hy Horng. All rights reserved.
//

import UIKit

class DopeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        let item0 = generateNavController(vc: ViewController(), title: "Home Page", image: UIImage(named: "home")!)
        let item1 = generateNavController(vc: ViewController(), title: "Contact Us", image: UIImage(named: "contact")!)
        let item2 = generateNavController(vc: ViewController(), title: "Pictures Album", image: UIImage(named: "camara")!)
        let item3 = generateNavController(vc: ViewController(), title: "Move to trash", image: UIImage(named: "trash")!)
        
        viewControllers = [item0, item1, item2, item3]
        
        
    }
    
    func generateNavController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
//        navController.navigationBar.backgroundColor = .orange
        
        return navController
    }
}
