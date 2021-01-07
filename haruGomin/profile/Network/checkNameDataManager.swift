//
//  checkNameDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/30.
//  Copyright © 2020 이진하. All rights reserved.
//
struct checkFlag: Codable {
    let flag: Bool?
}


import Alamofire


class checkNameDataManager {
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //    let SceneDelegate = UIApplication.shared.delegate as! SceneDelegate
    func check(_ profileVC: setProfileViewController, name: String , age:String , imageNum:String) {
        let url = "http://15.165.183.122:8080/api/v1/users/check/nickname?nickname=\(name)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let request = AF.request(encodedUrl as! URLConvertible, method: .get , encoding: JSONEncoding.default).validate()
        request.responseJSON { (response) in
            print("DEBUG: ageRange is \(age)")
            switch response.result {
            case .success(let obj):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(checkFlag.self, from: dataJSON)
                    guard let flag:Bool = getData.flag else { return }
                    print("DEBUG: flag is \(flag)")
                    if flag {
                        let selectVC = selectGominViewController()
                        selectVC.age = age
                        selectVC.nickName = name
                        selectVC.Img = imageNum
                        profileVC.navigationController?.pushViewController(selectVC, animated: true)
                    }else{
                        let alert = UIAlertController(title: "닉네임 중복", message: "중복된 닉네임 입니다!", preferredStyle: .alert)
                        let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                        alert.addAction(cancel)
                        profileVC.present(alert, animated: true, completion: nil)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            default:
                return
                
            }
            
            
        }
    }
}

