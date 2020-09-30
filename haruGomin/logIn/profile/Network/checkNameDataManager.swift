//
//  checkNameDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/30.
//  Copyright © 2020 이진하. All rights reserved.
//



import Alamofire


class checkNameDataManager {
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //    let SceneDelegate = UIApplication.shared.delegate as! SceneDelegate
    func check(_ profileVC: setProfileViewController, name: String , age:String) {
        let url = "http://52.78.127.67:8080/api/v1/users/check/\(name)"
        let request = AF.request(url, method: .get)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let obj):
                print(obj)
                if obj as! Int == 1 {
                    let selectVC  = selectGominViewController()
                    selectVC.nickName = name
                    selectVC.age = age
                    profileVC.navigationController?.pushViewController(selectVC, animated: true)
                }else{
                    print("이미 존재하는 닉네임입니다!")
                }
            default:
                return
                
            }
            
            
        }
    }
}

