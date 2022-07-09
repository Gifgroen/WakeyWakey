//
//  Created by Karsten Westra on 09/05/2022.
//

import Foundation

struct VideoFile: Decodable {
    let id: Int
    let quality: String?
    let file_type: String?
    let width: Int?
    let height: Int?
    let link: String?
}

struct VideoPicture: Decodable {
    let id: Int
    let picture: String
}

struct Video: Identifiable, Decodable {
    let id: Int
    let image: String

    let video_files: [VideoFile]
    let video_pictures: [VideoPicture]
}


