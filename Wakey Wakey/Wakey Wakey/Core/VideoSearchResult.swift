//
// Created by Karsten Westra on 09/07/2022.
//

import Foundation

struct VideoSearchResult: Decodable {
    let url: String
    let videos: [Video]
}