

import Alamofire

struct UserToeken: Codable {
    let jwt: String?
    let status: String?
}

class LoginDataManager {
    static let shared = LoginDataManager()
    private init() {}
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //    let SceneDelegate = UIApplication.shared.delegate as! SceneDelegate
    
    func alreadyUser(_ loginVC: logInViewController, jwt: String , token:String , id:Int64) {
        let headers: HTTPHeaders = [
            HTTPHeader(name: "jwt", value: jwt)
        ]
        let url = "http://52.78.127.67:8080/api/v1/users/check"
        AF.request(url, method: .post, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success(let obj):
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode(userInfo.self, from: dataJSON)
                        UserDefaults.standard.setValue(getData.userId, forKey: "userId")
                        UserDefaults.standard.setValue(getData.profileImage, forKey: "profileImage")
                        UserDefaults.standard.setValue(getData.ageRange, forKey: "ageRange")
                        UserDefaults.standard.setValue(getData.nickname, forKey: "userName")
                        
                        //로그인 성공 , 메인으로 넘어가기
                        let mainVC = tabBarViewController()
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = mainVC
                            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
                        } else {
                            mainVC.modalPresentationStyle = .overFullScreen
                            loginVC
                                .present(mainVC, animated: true, completion: nil)
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "회원정보 없음!", message: "회원가입 해주세요!", preferredStyle: .alert)
                    loginVC.present(alert, animated: true) {
                        self.login(loginVC, token: token, id: id)
                    }
                default:
                    return
                }
            }
        
    }
    
    func login(_ loginVC: logInViewController, token: String, id: Int64) {
        let url = "http://52.78.127.67:8080/api/v1/users/login/kakao"
        let headers: HTTPHeaders = [
            HTTPHeader(name: "accessToken", value: token)
        ]
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode(UserToeken.self, from: dataJSON)
                        guard let jwt:String = getData.jwt else { return }
                        print("DEBUG: AccessTokenInfo is \(jwt)")
                        print("DEBUG: login is Success")
                        UserDefaults.standard.setValue(jwt, forKey: "jwt")
                        UserDefaults.standard.setValue(id, forKey: "userId")
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

