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
    
    func registComment(_ detailVC : detailGominViewController,_ commentVC: commentViewController ,parameters:[String:Any]) {
        let url = "http://52.78.127.67:8080/api/v1/comments"
        AF.request(url, method: .post , parameters: parameters , encoding:  JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    commentDataManager.shared.getGominDetail(commentVC, postId: parameters["postId"] as! Int, pageNum: 0)
                    detailVC.commentTextField.text = ""
                    detailVC.commentBtn.setImage(UIImage(named: "sendMessageGray"), for: .normal)
                    detailVC.commentBtn.isEnabled  = false
                default:
                    return
                }
            }
    }
}
