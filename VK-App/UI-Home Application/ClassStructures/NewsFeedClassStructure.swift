//
//  NewsFeedClassStructure.swift
//  UI-Home Application
//
//  Created by Sam Mazniker on 10/09/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import ObjectMapper
import RealmSwift
import Foundation


class ServerNewsFeedResponse: Mappable{
    var response: NewsFeedInternal? = nil
    
    required init?(map: Map) { }
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class NewsFeedInternal: Mappable{
    var items: [NewsFeedPost] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}

class NewsFeedPost: Mappable{
    var type: String = ""
    var source_id: Int = 0
    var UNIXdate: Double = 0.0
    var date: String = ""
    var text: String = ""
    var attachment: [Attachment] = []
    var likes: Likes? = nil
    var views: Views? = nil
    var comments: Comments? = nil
    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        type <- map["type"]
        source_id <- map["source_id"]
        UNIXdate <- map["date"]
        text <- map["text"]
        attachment <- map["attachments"]
        likes <- map["likes"]
        views <- map["views"]
        comments <- map["comments"]
        
        DispatchQueue.global(qos: .utility).async {
            let NSdate = NSDate(timeIntervalSince1970: self.UNIXdate)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd YYYY hh:mm a"
            self.date = formatter.string(from: NSdate as Date)
        }
    }
}

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

class Likes: Mappable {
    var count: Int = 0
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        count <- map["count"]
    }
}

class Comments: Mappable {
    var count: Int = 0
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        count <- map["count"]
    }
}

class Views: Mappable {
    var count: Int = 0
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        count <- map["count"]
    }
}

