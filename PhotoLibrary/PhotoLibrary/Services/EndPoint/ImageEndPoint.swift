//
//  ImageEndPoint.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

enum FavoritesSort: String {
    case oldest, newest
}

enum ImageEndPoint {
    case getGalleryImages(pageNumber: Int?)
    case getAccountImages(pageNumber: Int?)
    case getFavouriteImages(pageNumber: Int?, sort: FavoritesSort?)
    case searchImages(keyword: String, pageNumber: Int?)
    case favouriteTheImage(id: String)
}

extension ImageEndPoint: EndPointType {
    
    private enum Constants {
        static let path = "account/rakeshkusuma/images"
        static let favouritesPath = "account/rakeshkusuma/favorites"
        static let authorization = "Authorization"
        static let bearer = "Bearer"
        static let clientID = "Client-ID"
        static let accessToken = "f656df67bcf63b8c48943f001a83caa79d9f1513"
        static let clientIDValue = "030372e3285ca4e"
        static let galleryPath = "gallery/hot/viral/day"
        static let searchPath = "gallery/search"
    }
    
    
    var baseURL: URL {
        guard let url = URL(string: Environment.imgurURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAccountImages(pageNumber: let pageNumber):
            if let page = pageNumber {
                return "\(Constants.path)/\(page)"
            } else {
                return Constants.path
            }
        case .getFavouriteImages(pageNumber: let pageNumber, sort: let sort):
            var path = Constants.favouritesPath
            if let page = pageNumber {
                path = "\(path)/\(page)"
            }
            if let sort = sort {
                path = "\(path)/\(sort.rawValue)"
            }
            return path
        case .searchImages(keyword: _, pageNumber: let pageNumber):
            var path = Constants.searchPath
            if let page = pageNumber {
                path = "\(path)/\(page)"
            }
            return path
        case .favouriteTheImage(id: let id):
            return "image/\(id)/favorite"
        case .getGalleryImages(pageNumber: let pageNumber):
            if let page = pageNumber {
                return "\(Constants.galleryPath)/\(page)"
            } else {
                return Constants.path
            }
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getGalleryImages, .getAccountImages, .getFavouriteImages, .searchImages:
            return .get
        case .favouriteTheImage:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getGalleryImages, .getAccountImages, .getFavouriteImages, .favouriteTheImage:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        case .searchImages(let keyword, _):
            let urlParameters = ["q": keyword]
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParameters, additionHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        var httpHeaders = ["Content-Type": "application/json",
                           "Accept": "application/json"]
        switch self {
        case .getGalleryImages, .getAccountImages, .getFavouriteImages, .favouriteTheImage:
            httpHeaders[Constants.authorization] = "\(Constants.bearer) \(Constants.accessToken)"
        case .searchImages:
            httpHeaders[Constants.authorization] = "\(Constants.clientID) \(Constants.clientIDValue)"
        }
        return httpHeaders
    }
}
