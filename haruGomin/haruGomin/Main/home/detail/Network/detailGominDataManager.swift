//
//  detailGominDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/03.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class detailGominDataManager{
    static let shared = detailGominDataManager()
    private init() {}
    func getGominDetail(_ detailVC:detailGominViewController , postId:Int , pageNum:Int ) {
        let url = "http://15.165.183.122:8080/api/v1/posts/\(postId)?pageNum=\(pageNum)"
        AF.request(url, method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode(gomin.self, from: dataJSON)
                        detailVC.setGominContent(gomin: getData)
                        detailVC.commentVC.userId = getData.userId!
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
}
