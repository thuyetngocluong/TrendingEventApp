//
//  DateExtension.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/30/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation

extension String {
    var toTrendingDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd/MM/yyyy: HH:mm:ss Z"
        return dateFormatter.date(from: self)
    }
    
    var toYoutubeDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: self)
    }
}

extension Date {
    var toHourAgo: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        return dateFormatter.string(from: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - self.timeIntervalSince1970))
    }
}
