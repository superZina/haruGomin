//
//  deleteUserDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/09.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class deleteUserDataManager{
    static let shared = deleteUserDataManager()
    private init () {}
    func deleteUser(_ myPageVC : myPageViewController , userId: Int64) {
        let url = "http://52.78.127.67:8080/api/v1/users/\(userId)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(url)
        AF.request(encodedUrl as! URLConvertible , method: .delete)
            .validate()
            .response { (response) in
                print(response.result)
                switch response.result {
                case .success(let obj):
                    print("delete success")
                    let loginVC = logInViewController()
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UINavigationController(rootViewController:loginVC)
                        UIView.transition(with: window, duration: 0.5, options: .beginFromCurrentState, animations: {}, completion: nil)
                    } else {
                        loginVC.modalPresentationStyle = .overFullScreen
                        myPageVC
                            .present(loginVC, animated: true, completion: nil)
                    }
                default:
                    print("delete failure")
                    return
                }
            }
    }
}
