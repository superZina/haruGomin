//
//  myPostingDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/05.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class myPostingDataManager{
    static let shared = myPostingDataManager()
    private init() {}
    func getmyPostings(myPageVC :myPageViewController , userId:Int64 , pageNum:Int) {
        let url = "http://15.165.183.122:8080/api/v1/users/posts/\(userId)?pageNum=\(pageNum)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedUrl as! URLConvertible , method: .get )
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode([addedGomin].self, from: dataJSON)
                        if pageNum != 0 {
                        myPageVC.myPosting.append(contentsOf: getData)
                        }else{
                            myPageVC.pageNum = 0
                            myPageVC.myPosting = getData
                        }
                        print(getData)
                        myPageVC.setmyPosting()
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
}
