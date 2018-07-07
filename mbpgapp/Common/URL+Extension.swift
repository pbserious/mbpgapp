//
//  URL+Extension.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 7/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import Foundation

extension URL {
    // Solved url to https, do not want to allow arbitary loads in Info.plist
    var httpsURL: URL? {
        var comp = URLComponents(url: self, resolvingAgainstBaseURL: false)
        comp?.scheme = "https"
        return comp?.url
    }
}
