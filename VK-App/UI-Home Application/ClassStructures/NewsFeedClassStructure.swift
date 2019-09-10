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
    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        type <- map["type"]
        source_id <- map["source_id"]
        UNIXdate <- map["date"]

        let NSdate = NSDate(timeIntervalSince1970: UNIXdate)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd YYYY hh:mm a"
        date = formatter.string(from: NSdate as Date)
        
        text <- map["text"]
    }
}

