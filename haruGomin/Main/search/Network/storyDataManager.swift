//
//  storyDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/12.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class storyDataManager{
    static let shared = storyDataManager()
    private init() {}
    func getStoryList(_ searchVC: searchViewController) {
        let url = "http://52.78.127.67:8080/api/v1/posts/home/story"
        AF.request(url, method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj):
                    print(obj)
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode([addedGomin].self, from: dataJSON)
                        searchVC.storys = getData
                        print(getData)
                        searchVC.setStorys()
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
        }
    }
}
