//
//  appleLoginDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/21.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire
struct appleToken:Codable {
    let access_token:String?
    let expires_in:Int?
    let id_token:String?
    let refresh_token:String?
    let token_type:String?
}

class appleLoginDataManager{
    static let shared = appleLoginDataManager()
    private init() {}
    func appleLogin(_ loginVC: logInViewController, id_token: String, id: Int64 ,state:String? , user:String , code:String) {
        let url = "http://52.78.127.67:8080/api/v1/users/login/apple"
//        let headers: HTTPHeaders = [
//            HTTPHeader(name: "accessToken", value: id_token)
//        ]
        let parameters:[String:Any] = [
            "code" : code,
            "id_token" : id_token,
            "state" : "test" ,
            "user" : user
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .response { (response) in
                switch response.result {
                case .success(let obj):
                    print(obj)
//                    do {
//                        UserDefaults.standard.setValue(user, forKey: "userId")
//                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
//                        let getData = try JSONDecoder().decode(appleToken.self, from: dataJSON)
//                        guard let jwt:String = getData.id_token else { return }
//                        UserDefaults.standard.setValue(jwt, forKey: "jwt")
//                        UserDefaults.standard.setValue(id, forKey: "userId")
//                        checkUserDataManager.shared.checkUser(loginVC, jwt: jwt)
//                    }catch {
//                        print(error.localizedDescription)
//                    }
                default:
                    print(response.error)
                    return
                }
            }
    }
}
