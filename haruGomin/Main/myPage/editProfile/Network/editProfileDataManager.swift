//
//  signUpDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/30.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class editProfileDataManager {
    static let shared = editProfileDataManager()
    private init() {}
    func editProfile(_ editVC: editProfileViewController, parameter:[String:Any]) {
//        print(parameter)
        print(parameter)
        let url = "http://52.78.127.67:8080/api/v1/users"
        let request = AF.request(url, method: .put, parameters: parameter, encoding: JSONEncoding.default).validate()
        request.responseJSON { (response) in
            print(parameter)
            print(response)
            switch response.result {
            case .success(let obj):
                print(obj)
                do {
                    print(obj)
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(Profile.self, from: dataJSON)
                    
                    UserDefaults.standard.setValue(getData.nickname, forKey: "userName")
                    UserDefaults.standard.setValue(getData.userId, forKey: "userId")
                    UserDefaults.standard.setValue(getData.profileImage, forKey: "profileImage")
                    UserDefaults.standard.setValue(getData.ageRange, forKey: "ageRange")
                    
                    let alert = UIAlertController(title: nil, message: "프로필 수정이 완료 됐어요!", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "확인", style: .cancel) { (action) in
                        editVC.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(cancel)
                    editVC.present(alert, animated: true) {
                    }
                    
                }catch {
//                    print(error.localizedDescription)
                }
            default:
                return
                
            }
            
            
        }
    }
}
