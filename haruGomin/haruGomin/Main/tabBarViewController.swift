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
        self.tabBar.backgroundColor = ColorPalette.darkBackground
        let homeVC = homeViewController()
        let searchVC =  searchViewController()
        let addVC = addGominViewController()
        let notice = noticeViewController()
        let myPageVC = myPageViewController()
        let icon1 =  UITabBarItem(title: nil, image: UIImage(named: "homeOff"), selectedImage: UIImage(named: "homeOn"))
        let icon2 =  UITabBarItem(title: nil, image: UIImage(named: "searchOff"), selectedImage: UIImage(named: "searchOn"))
        let icon3 =  UITabBarItem(title: nil, image: UIImage(named: "add"), selectedImage: UIImage(named: "add"))
      
        let icon5 =  UITabBarItem(title: nil, image: UIImage(named: "myOff"), selectedImage: UIImage(named: "myOn"))
        homeVC.tabBarItem = icon1
        searchVC.tabBarItem = icon2
        addVC.tabBarItem = icon3
        myPageVC.tabBarItem = icon5
        let vcs = [homeVC,searchVC,addVC, myPageVC]
        self.viewControllers = vcs
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
          if viewController.isKind(of: addGominViewController.self) {
             let vc =  addGominViewController()
             vc.modalPresentationStyle = .overFullScreen
             self.present(vc, animated: true, completion: nil)
             return false
          }
          return true
        }
}
