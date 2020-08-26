//
//  logInViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/08/27.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class logInViewController: UIViewController {

  
    @IBAction func kakaoLogin(_ sender: Any) {
        AuthApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
            }else {
                print("login with kakao is success.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
