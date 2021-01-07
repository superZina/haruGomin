//
//  mainGominDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/03.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire



class mainGominDataManager {
    static let shared = mainGominDataManager()
    private init() {}
    func getMainGomin(_ homeVC:homeViewController , _ userId: Int) {
        let url = "http://15.165.183.122:8080/api/v1/posts/main?userId=\(userId)"
        AF.request(url, method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode([gomin].self, from: dataJSON)
                        print(getData)
                        homeVC.gomins = getData
                        homeVC.setGomin()
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
    
}
