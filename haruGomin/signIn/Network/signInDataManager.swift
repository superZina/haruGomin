//
//  signInDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/12/18.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class signInDataManager {
    static let shared = signInDataManager()
    private init() {}
    func signIn(_ signInVC:signInViewController , _ Id : String , _ password : String) {
        let url = "http://15.165.183.122:8080/api/v1/users/login?id=\(Id)&password=\(password)"
        let request = AF.request(url, method: .post).validate()
        request.responseJSON { (response) in
            switch response.result {
            case .success(let obj):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(Toeken.self, from: dataJSON)
                    if let jwt = getData.jwt as? String {
                        checkUserDataManager.shared.checkUser(signInVC, jwt: getData.jwt!)
                    }else{
                        if let error = getData.error as? String {
                            signInVC.presentAlert(title: "로그인 실패!", message: error)
                        }
                        
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            default:
                return
                
            }
        }
    }
    
}
