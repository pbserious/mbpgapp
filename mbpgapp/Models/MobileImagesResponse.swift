//
//  MobileImagesResponse.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation
import ObjectMapper

struct MobileImageResponse: Mappable {
    
    var id: Int = -1
    var mobileId: Int = -1
    var imageUrlString: String = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        mobileId <- map["mobile_id"]
        imageUrlString <- map["url"]
    }
    
}
