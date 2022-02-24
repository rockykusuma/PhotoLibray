//
//  GalleryServiceResponse.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation


// MARK: - GalleryServiceResponse
struct GalleryServiceResponse: Codable {
    let data: [Gallery]?
    let success: Bool?
    let status: Int?
}

// MARK: - Datum
struct Gallery: Codable {
    let id, title: String?
    let datumDescription: String?
    let datetime: Int?
    let cover: String?
    let coverWidth, coverHeight: Int?
    let accountURL: String?
    let accountID: Int?
    let views: Int?
    let link: String?
    let ups, downs, points, score: Int?
    let isAlbum: Bool?
    let favorite, nsfw: Bool?
    let commentCount, favoriteCount: Int?
    let topicID: Int?
    let imagesCount: Int?
    let inGallery, isAd: Bool?
    let adType: Int?
    let adURL: String?
    let inMostViral, includeAlbumAds: Bool?
    let images: [GalleryImage]?
    let animated: Bool?
    let width, height, size, bandwidth: Int?
    let hasSound: Bool?
    let edited: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case datetime, cover
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        case accountURL = "account_url"
        case accountID = "account_id"
        case views, link, ups, downs, points, score
        case isAlbum = "is_album"
        case favorite, nsfw
        case commentCount = "comment_count"
        case favoriteCount = "favorite_count"
        case topicID = "topic_id"
        case imagesCount = "images_count"
        case inGallery = "in_gallery"
        case isAd = "is_ad"
        case adType = "ad_type"
        case adURL = "ad_url"
        case inMostViral = "in_most_viral"
        case includeAlbumAds = "include_album_ads"
        case images
        case animated, width, height, size, bandwidth
        case hasSound = "has_sound"
        case edited
    }
}


// MARK: - Image
struct GalleryImage: Codable {
    let id: String?
    let title: String?
    let imageDescription: String?
    let datetime: Int?
    let type: String?
    let animated: Bool?
    let width, height, size, views: Int?
    let bandwidth: Int?
    let favorite: Bool?
    let isAd, inMostViral, hasSound: Bool?
    let adType: Int?
    let adURL, edited: String?
    let inGallery: Bool?
    let link: String?
    let mp4Size: Int?
    let mp4: String?
    let gifv: String?
    let hls: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageDescription = "description"
        case datetime, type, animated, width, height, size, views, bandwidth, favorite
        case isAd = "is_ad"
        case inMostViral = "in_most_viral"
        case hasSound = "has_sound"
        case adType = "ad_type"
        case adURL = "ad_url"
        case edited
        case inGallery = "in_gallery"
        case link
        case mp4Size = "mp4_size"
        case mp4, gifv, hls
    }
}
