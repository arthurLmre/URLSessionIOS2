//
//  SeriesCharacter.swift
//  URLSession
//
//  Created by lpiem on 13/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import Foundation

struct SeriesCharacter {
    let characterID: Int
    let name: String
    let imageURL: String
    let creationDate: Date
}

extension SeriesCharacter: Decodable {
    enum CodingKeys: String, CodingKey { // on passe le nom qu'il y a dans l'api dans les case sinon rien si appelé pareil (comme name)
        case characterID = "id"
        case imageURL = "image"
        case name
        case creationDate = "created"
    }
}
