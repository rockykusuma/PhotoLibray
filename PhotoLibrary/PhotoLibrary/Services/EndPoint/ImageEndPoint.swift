//
//  ImageEndPoint.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

enum ImageEndPoint {
    case getAccountImages(pageNumber: Int?)
    case getFavouriteImages
    case searchImages(keyword: String)
}

extension ImageEndPoint: EndPointType {
    
    private enum Constants {
        static let path = "account/me/images"
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
        case .getAccountImages(let pageNumber):
            if let page = pageNumber {
                return "\(Constants.path)/\(page)"
            } else {
                return Constants.path
            }
        case .getFavouriteImages:
            return Constants.path
        case .searchImages(let keyword):
            return Constants.path
        }        
    }
    
    var httpMethod: HTTPMethod {
        .get
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
        }
    }
    
    var headers: HTTPHeaders? {
        let httpHeaders = ["Content-Type": "application/json",
                           "Accept": "application/json",
                           "isMobile": "true", Constants.authorization: "\(Constants.bearer) \(Constants.accessToken)"]
        return httpHeaders
    }
}
