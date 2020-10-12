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
        let url = "http://52.78.127.67:8080/api/v1/posts/\(postId)"
        print("DEBUG: url is \(url)")
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedUrl as! URLConvertible, method: .delete)
            .validate()
            .responseJSON { (response) in
                let alert = UIAlertController(title: nil, message: "고민 삭제 완료!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "확인", style: .cancel) { (action) in
                    myPageVC.writingCollectionView.reloadData()
                    myPageVC.viewWillAppear(true)
                    
                }
                alert.addAction(cancel)
                myPageVC.present(alert, animated: true, completion: nil)
            }
    }
}
