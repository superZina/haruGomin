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
    func getGominDetail(_ commentVC:commentViewController , postId:Int , pageNum:Int , userId : Int64 ) {
            let url = "http://15.165.183.122:8080/api/v1/comments/\(postId)?pageNum=\(pageNum)&userId=\(userId)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("DEBUG: uri is \(url)")
            AF.request(encodedUrl as! URLConvertible, method: .get)
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let obj):
                        do{
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            let getData = try JSONDecoder().decode([comment].self, from: dataJSON)
                            if pageNum == 0 {
                                commentVC.pageNum = 0
                                commentVC.comment = getData
                                
                            }else {
                            commentVC.comment.append(contentsOf: getData)
                            }
                        
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

