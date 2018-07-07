//
//  MobileData.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation
import ObjectMapper

struct MobileData: Mappable {
    
    var id: Int = -1
    var name: String = ""
    var brand: String = ""
    var rating: Float = 0.0
    var price: Double = 0.0
    var description: String = ""
    var thumnailUrlString: String = ""

    var thumbnailUrl: URL? {
        return URL(string: self.thumnailUrlString)
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        brand <- map["brand"]
        rating <- map["rating"]
        price <- map["price"]
        description <- map["description"]
        thumnailUrlString <- map["thumbImageURL"]
    }

}
