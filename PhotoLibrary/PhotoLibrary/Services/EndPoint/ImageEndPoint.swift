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
    case getAccountImages(pageNumber: Int?)
    case getFavouriteImages(pageNumber: Int?, sort: FavoritesSort?)
    case searchImages(keyword: String)
    case favouriteTheImage(id: String)
}

extension ImageEndPoint: EndPointType {
    
    private enum Constants {
        static let path = "account/rakeshkusuma/images"
        static let favouritesPath = "account/rakeshkusuma/favorites"
        static let authorization = "Authorization"
        static let bearer = "Bearer"
        static let accessToken = "f656df67bcf63b8c48943f001a83caa79d9f1513"
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
        case .searchImages(let keyword):
            return "\(Constants.path)/\(keyword)"
        case .favouriteTheImage(id: let id):
            return "image/\(id)/favorite"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAccountImages:
            return .get
        case .getFavouriteImages:
            return .get
        case .searchImages:
            return .get
        case .favouriteTheImage:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAccountImages:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        case .getFavouriteImages:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        case .searchImages(let keyword):
            let bodyParameters = ["keyword": keyword]
            return .requestParametersAndHeaders(bodyParameters: bodyParameters, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        case .favouriteTheImage:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        let httpHeaders = ["Content-Type": "application/json",
                           "Accept": "application/json",
                           "isMobile": "true",
                           Constants.authorization: "\(Constants.bearer) \(Constants.accessToken)"]
        return httpHeaders
    }
}
