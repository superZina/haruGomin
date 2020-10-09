//
//  checkUserDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class checkUserDataManager{
    static let shared = checkUserDataManager()
    private init() {}
    func checkUser(_ loginVC:logInViewController , jwt:String) {
        let headers: HTTPHeaders = [
            HTTPHeader(name: "jwt", value: jwt)
        ]
        let url = "http://52.78.127.67:8080/api/v1/users/check"
        AF.request(url , method: .post,headers:  headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    print("already user")
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode(userInfo.self, from: dataJSON)
                        UserDefaults.standard.setValue(getData.userId, forKey: "userId")
                        UserDefaults.standard.setValue(getData.profileImage, forKey: "profileImage")
                        UserDefaults.standard.setValue(getData.ageRange, forKey: "ageRange")
                        UserDefaults.standard.setValue(getData.nickname, forKey: "userName")
                        print("DEBUG: userInfo is \(getData)")
                        
                        //로그인 성공 , 메인으로 넘어가기
                        
                        if getData.ageRange != 0 { //회원가입일때
                            let profileVC = setProfileViewController()
                            let mainVC = tabBarViewController()
                            if let window = UIApplication.shared.windows.first {
                                window.rootViewController = UINavigationController(rootViewController:mainVC)
                                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
                            } else {
                                mainVC.modalPresentationStyle = .overFullScreen
                                loginVC
                                    .present(mainVC, animated: true, completion: nil)
                            }
                        }else{ //이미 가입된 유저일때
                            let profileVC = setProfileViewController()
                            
                            if let window = UIApplication.shared.windows.first {
                                window.rootViewController = UINavigationController(rootViewController:profileVC)
                                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
                            } else {
                                profileVC.modalPresentationStyle = .overFullScreen
                                loginVC
                                    .present(profileVC, animated: true, completion: nil)
                            }
                        }
                        
                    }catch{
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error)
                    print("new user")
                    let profileVC = setProfileViewController()
                    loginVC.navigationController?.pushViewController(profileVC, animated: true)
                default:
                    
                    return
                }
            }
    }
}
