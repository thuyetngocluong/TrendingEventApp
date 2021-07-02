//
//  TrendingModel.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/29/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation

enum TrendingInfo : String {
    case item = "item"
    case title = "title"
    case approxTraffic = "ht:approx_traffic"
    case itemDescription = "description"
    case link = "link"
    case pubDate = "pubDate"
    case picture = "ht:picture"
    case pictureSouce = "ht:picture_source"
    case newsItem = "ht:news_item"
    case newsItemTitle = "ht:news_item_title"
    case newsItemSnippet = "ht:news_item_snippet"
    case newsItemURL = "ht:news_item_url"
    case newsItemSource = "ht:news_item_source"
}

// MARK: - Item
struct ItemTrending {
    let title: String
    let approxTraffic: String
    let itemDescription: String
    let link: String
    let pubDate: String
    let picture, pictureSource: String
    let newsItem: [NewsItemElement]
}

// MARK: - NewsItemElement
struct NewsItemElement {
    let newsItemTitle, newsItemSnippet, newsItemURL, newsItemSource: String
}
