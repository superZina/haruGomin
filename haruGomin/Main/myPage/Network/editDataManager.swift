//
//  editDataManager.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/08.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

class editDataManager{
    static let shared = editDataManager()
    private init() {}
    func editGomin(_ myPageVC:myPageViewController ,parameter:[String:Any]){
        let url = "http://52.78.127.67:8080/api/v1/users/posts"
    }
}
