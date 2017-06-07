//
//  Video.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/5/20.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import UIKit
import ObjectMapper

struct Video {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var channel: Channel?
}

extension Video: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        thumbnailImageName  <- map["thumbnail_image_name"]
        title               <- map["title"]
        numberOfViews       <- map["number_of_views"]
        uploadDate          <- map["uploadDate"]
        channel             <- map["channel"]
    }
}


struct Channel {
    var name: String?
    var profileImageName: String?
}

extension Channel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name                <- map["name"]
        profileImageName    <- map["profile_image_name"]
    }
}
