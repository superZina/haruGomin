//
//  commentDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/03.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class commentDataManager{
    
        static let shared = commentDataManager()
        private init() {}
        func getGominDetail(_ commentVC:commentViewController , postId:Int , pageNum:Int ) {
            let url = "http://52.78.127.67:8080/api/v1/comment/\(postId)?pageNum=\(pageNum)"
            AF.request(url, method: .get)
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let obj):
                        print(obj)
                        do{
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            let getData = try JSONDecoder().decode([comment].self, from: dataJSON)
                            commentVC.comment = getData
                            commentVC.commentTableVeiw.reloadData()
                            commentVC.commentTableVeiw.setNeedsDisplay()
                        }catch {
                            print(error.localizedDescription)
                        }
                    default:
                        return
                    }
                }
        }
    }

