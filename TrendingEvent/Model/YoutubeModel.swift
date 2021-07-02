//
//  YoutubeModel.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/29/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation

// MARK: - YoutubeModel
struct YoutubeModel: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfoYoutube
    let items: [ItemYoutube]
}

// MARK: - ItemYoutube
struct ItemYoutube: Codable {
    let kind, etag: String
    let id: IdYoutube
    let snippet: SnippetYoutube
}

// MARK: - IdYoutube
struct IdYoutube: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - SnippetYoutube
struct SnippetYoutube: Codable {
    let publishedAt: String
    let channelID, title, snippetDescription: String
    let thumbnails: ThumbnailsYoutube
    let channelTitle, liveBroadcastContent: String
    let publishTime: String

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}

// MARK: - ThumbnailsYoutube
struct ThumbnailsYoutube: Codable {
    let thumbnailsDefault, medium, high: DefaultYoutube

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - DefaultYoutube
struct DefaultYoutube: Codable {
    let url: String
    let width, height: Int
}

// MARK: - PageInfoYoutube
struct PageInfoYoutube: Codable {
    let totalResults, resultsPerPage: Int
}
