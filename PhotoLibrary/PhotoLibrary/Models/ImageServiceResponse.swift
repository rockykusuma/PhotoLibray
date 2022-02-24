//
//  ImageServiceResponse.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation
import MapKit

// MARK: - ImageServiceResponse
struct ImageServiceResponse: Codable {
    let data: [Photo]?
    let success: Bool?
    let status: Int?
}

// MARK: - Datum
struct Photo: Codable {
    let id: String?
    let title, datumDescription: String?
    let dateTime: Int?
    let type: String?
    let animated: Bool?
    let width, height, size, views: Int?
    let bandwidth: Int?
    let vote: String?
    let favorite: Bool?
    let nsfw, section: String?
    let accountURL: String?
    let accountID: Int?
    let isAd, inMostViral, hasSound: Bool?
    let tags: [Int]?
    let adType: Int?
    let adURL, edited: String?
    let inGallery: Bool?
    let deleteHash, name: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case type, animated, width, height, size, views, bandwidth, vote, favorite, nsfw, section
        case dateTime = "datetime"
        case accountURL = "account_url"
        case accountID = "account_id"
        case isAd = "is_ad"
        case inMostViral = "in_most_viral"
        case hasSound = "has_sound"
        case tags
        case adType = "ad_type"
        case adURL = "ad_url"
        case edited
        case inGallery = "in_gallery"
        case name, link
        case deleteHash = "deletehash"
    }
}
