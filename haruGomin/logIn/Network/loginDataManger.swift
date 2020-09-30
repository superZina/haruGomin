

import Alamofire

struct userToeken:Codable {
    let jwt:String?
    let status:String?
}

class loginDataManager {
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //    let SceneDelegate = UIApplication.shared.delegate as! SceneDelegate
    func login(_ loginVC: logInViewController, token: String, id: Int64) {
        let url = "http://52.78.127.67:8080/api/v1/users/login/kakao"
        let request = AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["accessToken": token])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let obj):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let getData = try JSONDecoder().decode(userToeken.self, from: dataJSON)
                    let jwt:String = getData.jwt!
                    UserDefaults.standard.setValue(jwt, forKey: "jwt")
                    UserDefaults.standard.setValue(id, forKey: "id")
                    let setprofileVC = setProfileViewController()
                    loginVC.navigationController?.pushViewController(setprofileVC, animated: true)
                }catch {
                    print(error.localizedDescription)
                }
            default:
                return
                
            }
            
            
        }
    }
}

