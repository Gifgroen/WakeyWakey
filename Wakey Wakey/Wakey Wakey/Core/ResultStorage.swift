//
// Created by Karsten Westra on 09/07/2022.
//

import Foundation

class ResultStorage {
    public static var values: [Video] = []

    public static func video(with: Video.ID) -> Video? {
        return values.first { (v: Video) in v.id == with }
    }
}
