//
//  Domain.swift
//  Wakey Wakey
//
//  Created by Karsten Westra on 09/05/2022.
//

import Foundation

struct Video: Decodable {
    let id: Int
    let image: String
}

struct DecodableType: Decodable {
    let url: String
    let videos: [Video]
}
