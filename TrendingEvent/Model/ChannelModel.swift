//
//  ChannelModel.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 7/1/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation

// MARK: - ChannelModel
struct ChannelModel: Codable {
    let kind, etag: String
    let pageInfo: PageInfoChannel
    let items: [ItemChannel]
}

// MARK: - ItemChannel
struct ItemChannel: Codable {
    let kind, etag, id: String
    let snippet: SnippetChannel
}

// MARK: - SnippetChannel
struct SnippetChannel: Codable {
    let title, snippetDescription, publishedAt: String
    let thumbnails: ThumbnailsChannel
    let localized: LocalizedChannel
    let country: String

    enum CodingKeys: String, CodingKey {
        case title
        case snippetDescription = "description"
        case publishedAt, thumbnails, localized, country
    }
}

// MARK: - LocalizedChannel
struct LocalizedChannel: Codable {
    let title, localizedDescription: String

    enum CodingKeys: String, CodingKey {
        case title
        case localizedDescription = "description"
    }
}

// MARK: - ThumbnailsChannel
struct ThumbnailsChannel: Codable {
    let thumbnailsDefault, medium, high: DefaultChannel

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - DefaultChannel
struct DefaultChannel: Codable {
    let url: String
    let width, height: Int
}

// MARK: - PageInfoChannel
struct PageInfoChannel: Codable {
    let totalResults, resultsPerPage: Int
}
