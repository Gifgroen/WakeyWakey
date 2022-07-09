//
//  Network.swift
//  Wakey Wakey
//
//  Created by Karsten Westra on 09/05/2022.
//

import Foundation
import Alamofire

struct SearchListInteractor {
    private enum Config {
        static let baseUrl = "https://api.pexels.com/videos/search"

        static let apiKey = ""
    }
    
    private let headers: HTTPHeaders = [
        "Authorization": Config.apiKey
    ]
    
    func search(query: String, completion: @escaping (VideoSearchResult) -> Void) {
        AF.request("\(Config.baseUrl)?query=\(query)", method: .get, headers: self.headers)
            .responseDecodable(of: VideoSearchResult.self) { response in
                if let err = response.error {
                    print("err: \(err)")
                }
                guard let res = response.value else { return }
                completion(res)
            }
    }
}

