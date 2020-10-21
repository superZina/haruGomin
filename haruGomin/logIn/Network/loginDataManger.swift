

import Alamofire

struct UserToeken: Codable {
    let jwt: String?
    let status: String?
}

class LoginDataManager {
    static let shared = LoginDataManager()
    private init() {}
    func login(_ loginVC: logInViewController, token: String, id: Int64 ,type:String) {
        let url = "http://52.78.127.67:8080/api/v1/users/login/\(type)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(encodedUrl)
        print(url)
        let headers: HTTPHeaders = [
            HTTPHeader(name: "accessToken", value: token)
        ]
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    print(obj)
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode(UserToeken.self, from: dataJSON)
                        guard let jwt:String = getData.jwt else { return }
                        UserDefaults.standard.setValue(jwt, forKey: "jwt")
                        UserDefaults.standard.setValue(id, forKey: "userId")
                        checkUserDataManager.shared.checkUser(loginVC, jwt: jwt)
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
}

