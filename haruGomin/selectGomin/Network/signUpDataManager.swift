//
//  signUpDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/30.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class signUpDataManager {
    func signUp(_ selectVC: selectGominViewController, parameter:[String:Any]) {
//        print(parameter)
        let url = "http://15.165.183.122:8080/api/v1/users/singup"
        let request = AF.request(url, method: .put, parameters: parameter, encoding: JSONEncoding.default).validate()
        request.responseJSON { (response) in
            print(parameter)
            print(response)
            switch response.result {
            case .success(let obj):
                print(obj)
//                do {
//                    print(obj)
//                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
//                    let getData = try JSONDecoder().decode(Profile.self, from: dataJSON)
//
//                    UserDefaults.standard.setValue(getData.nickname, forKey: "userName")
//                    UserDefaults.standard.setValue(getData.userId, forKey: "userId")
//                    UserDefaults.standard.setValue(getData.profileImage, forKey: "profileImage")
//                    UserDefaults.standard.setValue(true, forKey: "isLogin")
//                    UserDefaults.standard.setValue(getData.ageRange, forKey: "ageRange")
//
////                    UserDefaults.standard.set(getData.userHashtags, forKey: "hashtags")
//                    let mainVC = tabBarViewController()
//                    if let window = UIApplication.shared.windows.first {
//                        window.rootViewController = UINavigationController(rootViewController:mainVC)
//                        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
//                    } else {
//                        mainVC.modalPresentationStyle = .overFullScreen
//                        selectVC
//                            .present(mainVC, animated: true, completion: nil)
//                    }
//
//                }catch {
//                    print(error.localizedDescription)
//                }
            default:
                return
                
            }
            
            
        }
    }
}
