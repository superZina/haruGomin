//
//  mainGominResponse.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/03.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit

struct mainGominList: Codable {
    let gomins: [gomin?]?
}

struct gomin:Codable {
    let createdDate:String?
    let modifiedDate:String?
    let postId:Int?
    let title:String?
    let content:String?
    let tagName:String?
    let postImage:String?
    let hits:Int?
    let postLikes:Int?
}

struct comment:Codable {
    let createdDate:String?
    let modifiedDate:String?
    let commentId:Int?
    let userId:Int?
    let nickname:String?
    let profileImage:String?
    let content:String?
    let commentLikes:Int?
}
