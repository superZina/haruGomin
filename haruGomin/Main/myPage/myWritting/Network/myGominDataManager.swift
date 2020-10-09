//
//  myGominDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/06.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class myGominDataManager{
    static let shared = myGominDataManager()
    private init(){}
    func getmyGomins(myWritngVC: myWritingViewController , userId:Int64 , pageNum: Int){
        let url = "http://52.78.127.67:8080/api/v1/users/history/\(userId)?pageNum=\(pageNum)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedUrl as! URLConvertible , method: .get )
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    print("DEBUG: success")
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode([addedGomin].self, from: dataJSON)
                        myWritngVC.writings = getData
                        myWritngVC.reloadgomins()
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
    
}
