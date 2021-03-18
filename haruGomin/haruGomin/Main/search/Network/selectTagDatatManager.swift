//
//  selectTagDatatManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/05.
//  Copyright © 2020 이진하. All rights reserved.
//

import Alamofire

class selectTagDatatManager{
    static let shared = selectTagDatatManager()
    private init() {}
    var isPaginating = false
    func fetchData(tagName:String , pageNum:Int,pagination: Bool = false , completion : @escaping (Result<[addedGomin] , Error>) -> Void) {
        //pagination: true면 페이징 하고있음을 표시
        if pagination {
            isPaginating = true
        }
        
        let url = "http://15.165.183.122:8080/api/v1/posts/home/\(tagName)?pageNum=\(pageNum)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            AF.request(encodedUrl as! URLConvertible , method: .get )
                .validate()
                .responseJSON { (response) in
    
                    switch response.result {
                    case .success(let obj):
                        do{
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            let getData = try JSONDecoder().decode([addedGomin].self, from: dataJSON)
                                
                            completion(.success(pagination ? getData : []))
                            //데이터 넘겨준 후 ispaingnating 변수 false로 만듬
                            if pagination {
                                self.isPaginating = false
                            }
                        }catch {
                            print(error.localizedDescription)
                        }
                    default:
                        return
                    }
                }
        }
    }
    
    
    func getTagGomins(_ searchVC: searchViewController , tagName:String , pageNum:Int) {
        let url = "http://15.165.183.122:8080/api/v1/posts/home/\(tagName)?pageNum=\(pageNum)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(url)
        print(tagName)
        print(pageNum)
        AF.request(encodedUrl as! URLConvertible , method: .get )
            .validate()
            .responseJSON { (response) in
//                print(response)
                switch response.result {
                case .success(let obj):
                    do{
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getData = try JSONDecoder().decode([addedGomin].self, from: dataJSON)
                        searchVC.newGomins.append(contentsOf: getData)
                        searchVC.refreshGominTable()
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                default:
                    return
                }
            }
    }
}
