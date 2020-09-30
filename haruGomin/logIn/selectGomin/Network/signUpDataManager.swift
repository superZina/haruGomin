//
//  signUpDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/30.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class signUpDataManager {
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //    let SceneDelegate = UIApplication.shared.delegate as! SceneDelegate
    func signUp(_ selectVC: selectGominViewController, parameter:[String:Any]) {
//        print(parameter)
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
//                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
//                    let getData = try JSONDecoder().decode(UserToeken.self, from: dataJSON)
                    
                }catch {
//                    print(error.localizedDescription)
                }
            default:
                return
                
            }
            
            
        }
    }
}
