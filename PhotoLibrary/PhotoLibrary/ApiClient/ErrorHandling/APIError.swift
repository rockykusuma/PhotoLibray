//
//  APIError.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

enum HTTPStatus: Int {
    case updateSuccess = 200
    case creationSuccess = 201
    case submitSuccess = 202
    case noContent = 204
    case maxOkStatus = 299
    case badRequest = 400
    case unauthorised = 401
    case locked = 403
    case notFound = 404
    case basic409Error = 409
    case etagMismatchError = 412
    case serverError = 500
    case noInternet = -1009
    case serviceTimeout = -1001
    case unknown
}

/// API error class
class APIError: LocalizedError {
    public let errorDescription: String?
    public let errorCode: String?
    let httpCode: HTTPStatus
    
    /// Init Method
    /// - Parameters:
    ///   - errorDescription: 'String' description for the error optional
    ///   - httpCode: `HTTPStatus` status code returned from the API
    ///   - errorCode: `String` custom error code
    init(errorDescription: String?,
         httpCode: HTTPStatus = .unknown,
         errorCode: String?) {
        self.httpCode = httpCode
        self.errorDescription = errorDescription
        self.errorCode = errorCode
    }
}
