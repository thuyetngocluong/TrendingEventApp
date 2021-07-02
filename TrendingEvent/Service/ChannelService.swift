//
//  ChannelService.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 7/1/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation
import Alamofire

typealias CompleteGetChannel = (Bool, ChannelModel?) -> Void

class ChannelService {
    
    let url = "https://www.googleapis.com/youtube/v3/channels?part=snippet&key=\(GOOGLE_KEY_API)"
    
    private init() {}
    
    static let shared = ChannelService()
    
    func getChannel(id: String, completion: @escaping CompleteGetChannel) {
        AF.request(url, method: .get, parameters: ["id": id]).response(queue: DispatchQueue(label: "getChannel")) {
            response in
            if let data = response.data {
                let channelModel = self.decodeData(data: data)
                completion(true, channelModel)
            } else {
                completion(false, nil)
            }
        }
    }
    
    func decodeData(data: Data) -> ChannelModel? {
        let decoder = JSONDecoder()
        do {
            let channelModel = try decoder.decode(ChannelModel.self, from: data)
            return channelModel
        } catch {
            print(error)
        }
        return nil
    }
}
