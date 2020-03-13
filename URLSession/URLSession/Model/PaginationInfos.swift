//
//  PaginationInfos.swift
//  URLSession
//
//  Created by lpiem on 13/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import Foundation

struct PaginationInfos {
    let count: Int
    let pages: Int
    
    private let nextURLString: String
    private let previousURLString: String
    
    var nextURL: URL? {
        return URL(string: nextURLString)
    }
    
    var previousURL: URL? {
        return URL(string: previousURLString)
    }
}


extension PaginationInfos: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case nextURLString = "next"
        case previousURLString = "prev"
    }
}
