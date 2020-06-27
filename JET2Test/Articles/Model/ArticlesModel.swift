//
//  ArticlesModel.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

import UIKit
import UIKit
import ObjectMapper

//------------------------------------------------
//---- Artical Main model ------
//-----------------------------------------------

class ArticleModel:  Mappable {
    var id:String?
    var content:String?
    var comments:Int?
    var likes:Int?
    var userList = [ArticleUserModel]()
    var mediaList = [ArticleMediaModel]()
    var createdAt:String?
    
    required init?(map: Map) {
    }
    
    init(id:String?,content:String?,comments:Int?,likes:Int?,userList:[ArticleUserModel]?,mediaList:[ArticleMediaModel]?,createdAt:String?) {
        self.id = id
        self.content = content
        self.comments = comments
        self.likes = likes
        self.userList = userList ?? [ArticleUserModel]()
        self.mediaList = mediaList ?? [ArticleMediaModel]()
        self.createdAt = createdAt
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        comments <- map["comments"]
        likes <- map["likes"]
        userList <- map["user"]
        mediaList <- map["media"]
        createdAt <- map["createdAt"]
    }
}

//------------------------------------------------
//---- Artical User list model ------
//-----------------------------------------------
class ArticleUserModel:  Mappable {
    var id:String?
    var blogId:String?
    var createdAt:String?
    var name:String?
    var avatar:String?
    var lastname:String?
    var city:String?
    var designation:String?
    var about:String?
    
    required init?(map: Map) {
    }
    
  init(id:String?,blogId:String?,createdAt:String?,name:String?,avatar:String?,lastname:String?,city:String?,designation:String?,about:String?) {
        self.id = id
        self.blogId = blogId
        self.createdAt = createdAt
        self.name = name
        self.avatar = avatar
        self.lastname = lastname
        self.city = city
        self.designation = designation
        self.about = about
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        blogId <- map["blogId"]
        createdAt <- map["createdAt"]
        name <- map["name"]
        avatar <- map["avatar"]
        lastname <- map["lastname"]
        city <- map["city"]
        designation <- map["designation"]
        about <- map["about"]
        
    }
}

//------------------------------------------------
//---- Artical Media list model ------
//-----------------------------------------------
class ArticleMediaModel:  Mappable {
    var id:String?
    var blogId:String?
    var createdAt:String?
    var image:String?
    var title:String?
    var url:String?
    
    required init?(map: Map) {
    }
    
    init(id:String?,blogId:String?,createdAt:String?,image:String?,title:String?,url:String?) {
        self.id = id
        self.blogId = blogId
        self.createdAt = createdAt
        self.image = image
        self.title = title
        self.url = url
        
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        blogId <- map["blogId"]
        createdAt <- map["createdAt"]
        image <- map["image"]
        title <- map["title"]
        url <- map["url"]
        
    }
}
