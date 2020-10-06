//
//  registGominResponse.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/04.
//  Copyright © 2020 이진하. All rights reserved.
//

struct addedGomin:Codable {
    let createdDate:String?
    let modifiedDate:String?
    let postId:Int?
    let title:String?
    let content:String?
    let tagName:String?
    let postImage:String?
    let hits:Int?
    let postLikes:Int?
    let userId:Int64?
}

