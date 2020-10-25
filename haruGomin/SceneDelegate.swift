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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        var startVC:UIViewController = UIViewController()
        startVC = splashViewController()
        //        guard let _ = (scene as? UIWindowScene) else { return }
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

