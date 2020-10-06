//
//  registGominDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/04.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class registGominDataManager{
    static let shared = registGominDataManager()
    private init() {}
    func registGomin(_ addGominVC:addGominViewController , parameter:[String:Any]) {
        let url = "http://52.78.127.67:8080/api/v1/posts"
        AF.request(url, method: .post, parameters: parameter , encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode(addedGomin.self, from: dataJSON)
                        
                        print(getData)
                        let alert = UIAlertController(title: "고민등록 완료!", message: "고민이 등록됐어요!", preferredStyle: .alert)
                        let success = UIAlertAction(title: "확인", style: .default) { (action) in
                            addGominVC.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(success)
                        addGominVC.present(alert, animated: true, completion: nil)
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
}
