//
//  AttachmentClassStructure.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 23/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import ObjectMapper
import Foundation

class Attachment: Mappable{
    var type: String = ""
    var photo: Photo? = nil
    var video: Video? = nil
    var link: Link? = nil
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        type <- map["type"]
        if type == "photo" {
            photo <- map["photo"]
        } else if type == "video"{
            video <- map["video"]
        } else if type == "link"{
            link <- map["link"]
        }
    }
}

class Photo: Mappable{
    var id: Int = 0
    var owner_id: Int = 0
    var text: String = ""
    var imageURL: [Sizes] = []
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        owner_id <- map["owner_id"]
        text <- map["text"]
        imageURL <- map["sizes"]
    }
}

class Sizes: Mappable {
    var type: String = ""
    var URL: String = ""
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        type <- map["type"]
        URL <- map["url"]
    }
}

class Video: Mappable{
    var id: Int = 0
    var owner_id: Int = 0
    var description: String = ""
    var coverURL: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        owner_id <- map["owner_id"]
        description <- map["description"]
        coverURL <- map["photo_320"]
    }
}

class Link: Mappable{
    var url: String = ""
    var title: String = ""
    var description: String = ""
    var coverPhoto: Photo? = nil
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        url <- map["url"]
        title <- map["title"]
        description <- map["description"]
        coverPhoto <- map["photo"]
    }
}
