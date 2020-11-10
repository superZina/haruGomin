//
//  SceneDelegate.swift
//  haruGomin
//
//  Created by 이진하 on 2020/08/27.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import NaverThirdPartyLogin
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        var startVC:UIViewController = UIViewController()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore
        {
            print("Not first launch.")
            //token이 존재한다면 -> 토큰검증
            if let jwt = UserDefaults.standard.value(forKey: "jwt") {
                print("token이 존재")
                    let headers: HTTPHeaders = [
                        HTTPHeader(name: "jwt", value: jwt as! String)
                    ]
                    let url = "http://52.78.127.67:8080/api/v1/users/check"
                    AF.request(url , method: .post,headers:  headers)
                        .validate()
                        .responseJSON { (response) in
                            switch response.result {
                            case .success(let obj):
                                
                                do{
                                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                    let getData = try JSONDecoder().decode(userInfo.self, from: dataJSON)
                                    UserDefaults.standard.setValue(getData.userId, forKey: "userId")
                                    UserDefaults.standard.setValue(getData.profileImage, forKey: "profileImage")
                                    UserDefaults.standard.setValue(getData.ageRange, forKey: "ageRange")
                                    UserDefaults.standard.setValue(getData.nickname, forKey: "userName")
                                    print("DEBUG: userInfo is \(getData)")
                                    
                                    //로그인 성공 , 메인으로 넘어가기
                                    
                                    if getData.ageRange == 0 { //회원가입일때
                                        UserDefaults.standard.setValue(true, forKey: "isLogin")
                                        let profileVC = setProfileViewController()
                                        if let windowScene = scene as? UIWindowScene {
                                            let window = UIWindow(windowScene: windowScene)
                                            window.rootViewController = UINavigationController(rootViewController: profileVC)
                                            window.rootViewController?.navigationController?.navigationBar.shadowImage = UIImage()
                                            window.rootViewController?.navigationController?.navigationBar.isTranslucent = false
                                            window.rootViewController?.navigationController?.navigationBar.barTintColor = .white
                                            window.rootViewController?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowBackBlack")
                                            window.rootViewController?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowBackBlack")
                                            window.rootViewController?.navigationController?.navigationBar.backItem?.title = ""
                                            
                                            self.window = window
                                            window.makeKeyAndVisible()
                                        }
                                    }else{ //이미 가입된 유저일때
                                        
                                        let mainVC = tabBarViewController()
                                        if let windowScene = scene as? UIWindowScene {
                                            let window = UIWindow(windowScene: windowScene)
                                            window.rootViewController = UINavigationController(rootViewController: mainVC)
                                            window.rootViewController?.navigationController?.navigationBar.shadowImage = UIImage()
                                            window.rootViewController?.navigationController?.navigationBar.isTranslucent = false
                                            window.rootViewController?.navigationController?.navigationBar.barTintColor = .white
                                            window.rootViewController?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowBackBlack")
                                            window.rootViewController?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowBackBlack")
                                            window.rootViewController?.navigationController?.navigationBar.backItem?.title = ""
                                            
                                            self.window = window
                                            window.makeKeyAndVisible()
                                        }
                                        
                                    }
                                    
                                }catch{
                                    print(error.localizedDescription)
                                }
                            case .failure(let error):
                                
                                print(error.localizedDescription)
                                
                                startVC = logInViewController()
                                if let windowScene = scene as? UIWindowScene {
                                    let window = UIWindow(windowScene: windowScene)
                                    window.rootViewController = UINavigationController(rootViewController: startVC)
                                    window.rootViewController?.navigationController?.navigationBar.shadowImage = UIImage()
                                    window.rootViewController?.navigationController?.navigationBar.isTranslucent = false
                                    window.rootViewController?.navigationController?.navigationBar.barTintColor = .white
                                    window.rootViewController?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowBackBlack")
                                    window.rootViewController?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowBackBlack")
                                    window.rootViewController?.navigationController?.navigationBar.backItem?.title = ""
                                    
                                    self.window = window
                                    window.makeKeyAndVisible()
                                }
                            default:
                                return
                            }
                        }
            }else{
                //토큰이 유효하지 않는다면
                print("token is not available")
                startVC = logInViewController()
                if let windowScene = scene as? UIWindowScene {
                    let window = UIWindow(windowScene: windowScene)
                    window.rootViewController = UINavigationController(rootViewController: startVC)
                    window.rootViewController?.navigationController?.navigationBar.shadowImage = UIImage()
                    window.rootViewController?.navigationController?.navigationBar.isTranslucent = false
                    window.rootViewController?.navigationController?.navigationBar.barTintColor = .white
                    window.rootViewController?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowBackBlack")
                    window.rootViewController?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowBackBlack")
                    window.rootViewController?.navigationController?.navigationBar.backItem?.title = ""
                    
                    self.window = window
                    window.makeKeyAndVisible()
                }
            }
            
        }
        else{
            //처음 실행하는거라면(로그인도 안되어있음)
            print("First launch")
            startVC = splashViewController()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UINavigationController(rootViewController: startVC)
                window.rootViewController?.navigationController?.navigationBar.shadowImage = UIImage()
                window.rootViewController?.navigationController?.navigationBar.isTranslucent = false
                window.rootViewController?.navigationController?.navigationBar.barTintColor = .white
                window.rootViewController?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowBackBlack")
                window.rootViewController?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowBackBlack")
                window.rootViewController?.navigationController?.navigationBar.backItem?.title = ""
                
                self.window = window
                window.makeKeyAndVisible()
            }
        }
        
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
        NaverThirdPartyLoginConnection
          .getSharedInstance()?
          .receiveAccessToken(URLContexts.first?.url)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

