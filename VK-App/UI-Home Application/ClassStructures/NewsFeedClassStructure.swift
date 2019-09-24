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

