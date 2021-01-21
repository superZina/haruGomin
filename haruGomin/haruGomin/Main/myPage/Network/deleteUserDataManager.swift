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
        let url = "http://15.165.183.122:8080/api/v1/users/\(userId)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(url)
        AF.request(url , method: .delete)
            .validate()
            .response { (response) in
                print(response.result)
                switch response.result {
                case .success(let obj):
                    print("delete success")
                    let loginVC = logInViewController()
                    let alert = UIAlertController(title: "회원 탈퇴 완료!", message: "계정이 성공적으로 삭제 되었습니다!", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .cancel) { (action) in
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = UINavigationController(rootViewController:loginVC)
                            UIView.transition(with: window, duration: 0.5, options: .beginFromCurrentState, animations: {}, completion: nil)
                        } else {
                            loginVC.modalPresentationStyle = .overFullScreen
                            myPageVC
                                .present(loginVC, animated: true, completion: nil)
                        }
                    }
                    alert.addAction(ok)
                    myPageVC.present(alert, animated: true, completion: nil)
                default:
                    print("delete failure")
                    return
                }
            }
    }
}
