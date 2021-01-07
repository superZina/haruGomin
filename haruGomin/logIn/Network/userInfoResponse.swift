//
//  userInfoResponse.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/06.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

struct userInfo:Codable {
    let userId:Int64?
    let userLoginId:String?
    let nickname:String?
    let profileImage:String?
    let ageRange:Int?
    let userHashtags:[String]?
}
