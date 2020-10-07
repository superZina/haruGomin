//
//  searchDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/07.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class searchDataManager {
    static let shared = searchDataManager()
    private init() {}
    func getSearchResult(_ resultVC: searchResultViewController , _ keyword:String , _ pageNum:Int) {
        let url:String = "http://52.78.127.67:8080/api/v1/posts/home/\(keyword)?pageNum=\(pageNum)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedUrl as! URLConvertible , method:  .get)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    print(obj)
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode([addedGomin].self, from: dataJSON)
                        resultVC.results = getData
//                        print(getData)
                        resultVC.resultTableView.reloadData()
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
}
