//
//  registCommentDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/07.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class registCommentDataManager{
    static let shared = registCommentDataManager()
    private init() {}
    
    func registComment(_ commentVC: commentViewController ,parameters:[String:Any] , userId: Int64) {
        let url = "http://15.165.183.122:8080/api/v1/comments"
        AF.request(url, method: .post , parameters: parameters , encoding:  JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    commentDataManager.shared.getGominDetail(commentVC, postId: parameters["postId"] as! Int, pageNum: 0 , userId:  userId)
                    commentVC.commentTextField.text = ""
                    commentVC.commentBtn.setImage(UIImage(named: "sendMessageGray"), for: .normal)
                    commentVC.commentBtn.isEnabled  = false
                default:
                    return
                }
            }
    }
}
