//
//  tagListDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/05.
//  Copyright © 2020 이진하. All rights reserved.
//


import Alamofire

class tagListDataManager{
    static let shared = tagListDataManager()
    private init() {}
    func getTagList(_ searchVC: searchViewController) {
        let url = "http://15.165.183.122:8080/api/v1/posts/home/hashtag"
        AF.request(url, method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode([tagList].self, from: dataJSON)
                        searchVC.btnText = getData
                        print(getData)
                        searchVC.setTagList()
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
}
