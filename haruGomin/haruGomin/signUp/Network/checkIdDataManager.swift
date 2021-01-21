//
//  checkIdDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/12/11.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class checkIdDataManager{
    static let shared = checkIdDataManager()
    private init() {}
    func checkID(signUpVC : signUpViewController , id: String, pw : String) {
        let url = "http://15.165.183.122:8080/api/v1/users/check/id?id=\(id)"
        let request = AF.request(url, method: .get).validate()
        request.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(checkFlag.self, from: dataJSON)
                    guard let flag:Bool = getData.flag else { return }
                    if flag {
                        let setproVC = setProfileViewController()
                        UserDefaults.standard.setValue(id, forKey: "userId")
                        UserDefaults.standard.setValue(pw, forKey: "password")
                        signUpVC.navigationController?.pushViewController(setproVC, animated: true)
                        
                    }else{
                        signUpVC.presentAlert(title: "아이디 오류!" , message: "이미 존재하는 아이디입니다!" )
                    }
                }catch {
                    print(error.localizedDescription)
                }
            case .failure(_):
                print(response.error)
            }
        }
    }
}
