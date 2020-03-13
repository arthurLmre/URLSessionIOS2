//
//  PaginatedElements.swift
//  URLSession
//
//  Created by lpiem on 13/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import Foundation

struct PaginatedElements<T: Decodable> {
    let informations: PaginationInfos
    let decodedElements: [T]
}

extension PaginatedElements: Decodable {
    enum CodingKeys: String, CodingKey {
        case informations = "info"
        case decodedElements = "results"
    }
}
