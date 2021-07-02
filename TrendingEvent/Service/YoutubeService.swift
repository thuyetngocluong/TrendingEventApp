//
//  YoutubeService.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/29/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation
import Alamofire

typealias CompleteSearch = (Bool, YoutubeModel?) -> Void


let GOOGLE_KEY_API = "AIzaSyCJTxOGWvPbix4Q6ALc3VpbmvhptwO6lpQ"

class YoutubeService {
    let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&key=\(GOOGLE_KEY_API)"
    
    static let shared = YoutubeService()
    
    func search(content: String, completion: @escaping CompleteSearch) {
        AF.request(url, method: .get, parameters: ["q": content, "maxResults": 10]).response(queue: DispatchQueue(label: "searchYoutube")) {
            response in
            if let data = response.data {
                let youtubeModel = self.decodeData(data: data)
                completion(true, youtubeModel)
            } else {
                completion(false, nil)
            }
        }
      
    }
    
    func decodeData(data: Data) -> YoutubeModel? {
        var youtubeModel: YoutubeModel?
        let decoder = JSONDecoder()
        
        do {
            youtubeModel = try decoder.decode(YoutubeModel.self, from: data)
        } catch {
            print(error)
        }
        
        return youtubeModel
    }
}

