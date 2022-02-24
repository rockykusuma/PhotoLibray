//
//  FavouriteImageServiceResponse.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 23/02/22.
//

import Foundation

// MARK: - FavouriteImageServiceResponse
struct FavouriteImageServiceResponse: Codable {
    let data: [FavouritePhoto]?
    let success: Bool?
    let status: Int?
}

// MARK: - Datum
struct FavouritePhoto: Codable {
    let id, title, datumDescription, cover: String?
    let coverWidth, coverHeight, width, height: Int?
    let accountURL: String?
    let accountID: Int?
    let privacy: String?
    let views: Int?
    let link: String?
    let ups, downs, points, score: Int?
    let isAlbum: Bool?
    let vote: String?
    let favorite, nsfw: Bool?
    let section: String?
    let commentCount, favoriteCount: Int?
    let topic, topicID: String?
    let imagesCount, dateTime: Int?
    let inGallery, inMostViral: Bool?
    let tags: [Int]?
    let images: [Image]?
    let hasSound, animated: Bool?
    let type: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case cover
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        case width, height
        case accountURL = "account_url"
        case accountID = "account_id"
        case privacy, views, link, ups, downs, points, score
        case isAlbum = "is_album"
        case vote, favorite, nsfw, section
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case topic
        case topicID = "topic_id"
        case imagesCount = "images_count"
        case dateTime = "datetime"
        case inGallery = "in_gallery"
        case inMostViral = "in_most_viral"
        case tags, images
        case hasSound = "has_sound"
        case animated, type, size
    }
}

// MARK: - Image
struct Image: Codable {
    let id, deletehash: String?
    let accountID, accountURL, adType, adURL: String?
    let title, imageDescription: String?
    let name, type: String?
    let width, height, size, views: Int?
    let section, vote: String?
    let bandwidth: Int?
    let animated, favorite, inGallery, inMostViral: Bool?
    let hasSound, isAd: Bool?
    let nsfw: Bool?
    let link: String?
    let tags: [Int]?
    let datetime: Int?
    let mp4: String?
    let hls: String?

    enum CodingKeys: String, CodingKey {
        case id, deletehash
        case accountID = "account_id"
        case accountURL = "account_url"
        case adType = "ad_type"
        case adURL = "ad_url"
        case title
        case imageDescription = "description"
        case name, type, width, height, size, views, section, vote, bandwidth, animated, favorite
        case inGallery = "in_gallery"
        case inMostViral = "in_most_viral"
        case hasSound = "has_sound"
        case isAd = "is_ad"
        case nsfw, link, tags, datetime, mp4, hls
    }
}
