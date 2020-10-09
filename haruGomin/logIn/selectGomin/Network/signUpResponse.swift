//
//  signUpResponse.swift
//  haruGomin
//
//  Created by 이진하 on 2020/10/03.
//  Copyright © 2020 이진하. All rights reserved.
//

struct Profile:Codable {
    let userId:Int?
    let nickname:String?
    let profileImage:String?
    let ageRange:Int?
    let userHashtags:[Hashtag?]?

}
struct Hashtag:Codable {
    let userHashtagId:Int?
    let hashtag:tag?
}
struct tag:Codable {
    let tagId:Int?
    let tagName:String?
    let postingCount:Int?
}
