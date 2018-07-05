//
//  MobilesAPI.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 5/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation
import Moya

enum MobileAPI {
    case getList
    case getImages(id:Int)
}

extension MobileAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://scb-test-mobile.herokuapp.com/api/mobiles/")!
    }
    
    var path: String {
        switch self {
        case .getImages(let id):
            return "\(id)/images"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        // Currently not use sample data to mock up test
        return "".utf8Encoded
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

extension String {
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
