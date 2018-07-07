//
//  APIError.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 8/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

typealias ErrorMessageHandler = (String) -> Void

enum APIError: Error {
    case unparsableJSON
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .unparsableJSON:
            return "Can't not parse JSON"
        case .unknownError:
            return "Oops! Somethings went wrong. Please try again later"
        }
    }
}
