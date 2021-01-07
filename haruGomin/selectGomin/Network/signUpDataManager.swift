//
//  signUpDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/09/30.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

struct Toeken: Codable {
    let jwt: String?
    let error:String?
}

class signUpDataManager {
    func signUp(_ selectVC: selectGominViewController, _ ageRange: Int32 , _ nickname: String , _ password: String , _ profileImage : String , _ hashtags:[String] , _ loginId : String) {
        var url = "http://15.165.183.122:8080/api/v1/users/signup?ageRange=\(ageRange)&nickname=\(nickname)&password=\(password)&profileImage=\(profileImage)&userLoginId=\(loginId)"
        for tagname in hashtags {
            url += "&userhashtags=\(tagname)"
        }
        let enc_url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let request = AF.request(enc_url as! URLConvertible, method: .post , encoding: URLEncoding.queryString).validate()
        request.responseJSON { (response) in
            
            print(response)
            switch response.result {
            case .success(let obj):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(Toeken.self, from: dataJSON)
                    print(getData.jwt)
                    checkUserDataManager.shared.checkUser(selectVC, jwt: getData.jwt!)
                }catch{
                    print(error.localizedDescription)
                }
            default:
                return
                
            }
            
            
        }
    }
}
