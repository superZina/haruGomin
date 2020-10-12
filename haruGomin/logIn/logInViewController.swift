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
import AuthenticationServices

// 네이버로 로그인하기 : https://developer-fury.tistory.com/18

class logInViewController: UIViewController {
    
    
    @IBOutlet weak var kakaoBtn: UIButton!
    @IBOutlet weak var naverBtn: UIButton!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    @IBAction func logout(_ sender: Any) {
        loginInstance?.requestDeleteToken()
    }
    @IBAction func naverLogin(_ sender: Any) {
        //        oauth20ConnectionDidFinishDeleteToken()
        
        UserDefaults.standard.setValue("naver", forKey: "loginType")
        loginInstance?.delegate = self
        //        loginInstance?.requestDeleteToken()
        loginInstance?.requestThirdPartyLogin()
    }
    func setupProviderLoginView() {
       
        
//        self.appleLoginBtn.addSubview(authorizationButton)
    }
    @IBAction func appleLogin(_ sender: Any) {
        let authorizationButton = ASAuthorizationAppleIDButton()
//        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        UserDefaults.standard.setValue("apple", forKey: "loginType")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        UserDefaults.standard.setValue("apple", forKey: "loginType")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        UserDefaults.standard.setValue("kakao", forKey: "loginType")
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
                        print("DEBUG: AccessTokenInfo is \(oauthToken?.accessToken)")
                        
                        LoginDataManager.shared.login(self, token: oauthToken!.accessToken, id: id , type:"kakao")
                    }
                }
            }
            
        }
        //        let profileVC = setProfileViewController()
        //        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let kakaoIcon:UIImageView = UIImageView(frame: CGRect(x: 25, y: 15, width: 22, height: 21))
        kakaoIcon.image = UIImage(named: "shape2")
        kakaoBtn.addSubview(kakaoIcon)
        let naverIcon:UIImageView = UIImageView(frame: CGRect(x: 25, y: 16, width: 21, height: 19.2))
        naverIcon.image = UIImage(named: "fill1")
        naverBtn.addSubview(naverIcon)
        
        let appleIcon:UIImageView = UIImageView(frame: CGRect(x: 18, y: 0, width: 37, height: 52))
        appleIcon.image = UIImage(named: "leftBlackLogoMedium")
        appleLoginBtn.addSubview(appleIcon)
        
        self.view.backgroundColor = ColorPalette.background
        kakaoBtn.backgroundColor = UIColor(red: 254/255, green: 229/255, blue: 0, alpha: 1)
        naverBtn.backgroundColor = UIColor(red: 30/255, green: 200/255, blue: 0, alpha: 1)
        
        kakaoBtn.setTitleColor(UIColor(red: 24/255, green: 22/255, blue: 0, alpha: 1), for: .normal)
        appleLoginBtn.setTitleColor(UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1), for: .normal)
        
        appleLoginBtn.layer.cornerRadius = 8
        kakaoBtn.layer.cornerRadius = 8
        naverBtn.layer.cornerRadius = 8
        
        text1.textColor = ColorPalette.textGray
        setupProviderLoginView()
    }
    
    // MARK: 네이버 로그인 정보 가져오는 메서드
    fileprivate func getNaverLoginInfo(tokenType: String, accessToken: String) {
        guard let _ = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        let infoUrl = "https://openapi.naver.com/v1/nid/me"
        
        let headers: HTTPHeaders = [
            HTTPHeader(name: "Authorization", value: "\(tokenType) \(accessToken)")
        ]
        
        AF.request(infoUrl, method: .get, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let responseData):
                    guard let result = responseData as? [String: Any] else { return }
                    guard let data = result["response"] as? [String: Any] else { return }
                    print(data)
                    LoginDataManager.shared.login(self, token: accessToken, id: 0 , type:"naver")
                    
                case .failure(let error):
                    print("[Error] : \(error)")
                }
            }
    }
    
}


extension logInViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        print(loginInstance?.accessToken)
        if let token = loginInstance?.accessToken, let type = loginInstance?.tokenType {
            getNaverLoginInfo(tokenType: type, accessToken: token)
        }
        
        
        
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
    }
}
extension logInViewController:ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credenctial = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            print( "DEBUG: authorisation info is \(credenctial) ")
            print("DEBUG: token is \(String(describing: credenctial.identityToken))")
            print("DEBUG: user is \(credenctial.user)")
            print("DEBUG: userUTF8 is \(credenctial.user.utf8)")
            print("DEBUG: email is \(credenctial.email)")
            print("DEBUG: authorizationCode is \(String(data: credenctial.authorizationCode! , encoding: .utf8))")
            print("DEBUG: token is \(String(data: credenctial.identityToken!, encoding: .utf8))")
            print("DEBUG: state is \(credenctial.state)")
            
            
            let provider = ASAuthorizationAppleIDProvider()
            provider.getCredentialState(forUserID: credenctial.user) { state, error in
                switch state {
                case .authorized:
                print("authorized")
                
                case .revoked:
                    print("revoked")
                case .notFound:
                    print("notFound")
                case .transferred:
                    print("transferred")
                @unknown default:
                    return
                }
                
            }
        }
    }
}
