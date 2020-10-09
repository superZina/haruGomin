//
//  deleteDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/08.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class deleteDataManager{
    static let shared = deleteDataManager()
    private init() {}
    func deletePost(_ myPageVC:myPageViewController , postId:Int) {
        let url = "http://52.78.127.67:8080/api/v1/users/posts/\(postId)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url, method: .delete)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    print("delete success")
                    
                default:
                    return
                }
            }
    }
}
