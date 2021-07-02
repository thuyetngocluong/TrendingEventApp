//
//  ImageService.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/29/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit
import Alamofire

typealias CompleteDownloadImage = (Bool, UIImage?) -> Void

class ImageService {
    private init() {}
    static let shared = ImageService()
    
    func getUIImage(url: String, completeDownload: @escaping CompleteDownloadImage) {
        AF.request(url, method: .get)
            .response(queue: DispatchQueue(label: "getImage")) {
                response in
                if let data = response.data {
                    let uiImage = UIImage(data: data)
                    completeDownload(true, uiImage)
                } else {
                    completeDownload(false, nil)
                }
        }
    }
}
