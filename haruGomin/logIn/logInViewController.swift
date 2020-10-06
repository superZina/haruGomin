//
//  logInViewController.swift
//  haruGomin
//
//  Created by 이진하 on 2020/08/27.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

import Alamofire
import NaverThirdPartyLogin

// 네이버로 로그인하기 : https://developer-fury.tistory.com/18

class logInViewController: UIViewController{
    @IBOutlet weak var kakaoBtn: UIButton!
    @IBOutlet weak var naverBtn: UIButton!
    @IBOutlet weak var text1: UILabel!
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
  
    @IBAction func naverLogin(_ sender: Any) {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        AuthApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("login with kakao is success.")
//                var id: Int64 = 0
                UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("accessTokenInfo() success.")
                        //do something
                        guard let accessTokenInfo = accessTokenInfo else { return }
                        let id = accessTokenInfo.id
                        print("DEBUG: AccessTokenInfo is \(accessTokenInfo)")
                        print("DEBUG: AccessTokenInfo is \(oauthToken?.accessToken)")
                        if let jwt:String = UserDefaults.standard.value(forKey: "jwt") as! String {
                            LoginDataManager.shared.alreadyUser(self, jwt: jwt , token: oauthToken!.accessToken , id : id)
                        }else{ //회원이 아닐 때
                            LoginDataManager.shared.login(self, token: oauthToken!.accessToken, id: id)
                        }
                        
                    }
                }
                
                
            }
            
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.backgroundColor = ColorPalette.background
        kakaoBtn.backgroundColor = ColorPalette.hagoRed
        naverBtn.backgroundColor = ColorPalette.darkBackground
        
        kakaoBtn.layer.cornerRadius = 8
        naverBtn.layer.cornerRadius = 8
        
        text1.textColor = ColorPalette.textGray
    }
    func presentWebviewcontrollerWithRequest(request: URLRequest) {
//            let controller: NLoginThirdPartyOAuth20InAppBrowserViewController = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)
//            controller.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
//            present(controller, animated: true, completion: nil)
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
}


extension logInViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공했을 경우 호출
       func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
           print("[Success] : Success Naver Login")
       }
        // 접근 토큰 갱신
       func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
       }
         // 로그아웃 할 경우 호출(토큰 삭제)
       func oauth20ConnectionDidFinishDeleteToken() {
           loginInstance?.requestDeleteToken()
       }
       // 모든 Error
       func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
            print("[Error] :", error.localizedDescription)
       }
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
            presentWebviewcontrollerWithRequest(request: request)
    }
}
