//
//  logInViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/08/27.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit


class logInViewController: UIViewController {
      
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background
        
        self.loginBtn.layer.cornerRadius = 8
        self.signUpBtn.layer.cornerRadius = 8
        self.loginBtn.backgroundColor = ColorPalette.hagoRed
        self.signUpBtn.backgroundColor = ColorPalette.background
        self.loginBtn.setTitleColor(ColorPalette.darkBackground, for: .normal)
        
        self.signUpBtn.setTitleColor(ColorPalette.hagoRed, for: .normal)
        self.signUpBtn.layer.borderWidth = 1
        self.signUpBtn.layer.borderColor = ColorPalette.hagoRed.cgColor
        self.signUpBtn.titleLabel?.font = UIFont.fontButtonWhite
        self.loginBtn.titleLabel?.font = UIFont.fontButtonWhite
        
        self.text1.textColor = ColorPalette.textGray
        self.text2.textColor = ColorPalette.textGray
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func login(_ sender: Any) {
        let signInVC = signInViewController()
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = signUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}


