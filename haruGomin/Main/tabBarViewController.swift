//
//  tabBarViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class tabBarViewController: UITabBarController , UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.backgroundImage = UIImage()
        // Do any additional setup after loading the view.
        let homeVC = homeViewController()
        let vcs = [homeVC,homeVC,homeVC]
        self.viewControllers = vcs
    }
}
