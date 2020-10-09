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
        let url = "http://52.78.127.67:8080/api/v1/users/check/\(name)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let request = AF.request(encodedUrl as! URLConvertible, method: .get , encoding: JSONEncoding.default).validate()
        request.responseJSON { (response) in
            print("DEBUG: response is \(response)")
            switch response.result {
            case .success(let obj):
                print(obj)
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

