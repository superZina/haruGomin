//
//  commentLikeDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/07.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class commentLikeDataManager{
    static let shared = commentLikeDataManager()
    private init() {}
    func likeComment(commentVC: commentViewController , commentID:Int , userId: Int64) {
        let url = "http://52.78.127.67:8080/api/v1/comments/like?commentId=\(commentID)&userId=\(userId)"
        AF.request(url , method: .put)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj) :
                    print("DEBUG: like Comment Successfully")
                default:
                    return
                }
            }
    }
}
