//
//  RestResponse.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

protocol RestResponseProvider {
    var data: Data? { get set }
    var error: Error? { get }
    var hasError: Bool { get }
    var hasData: Bool { get }
    var httpStatusCode: HTTPStatus { get }
    var headers: [AnyHashable: Any] { get }
}

class RestResponse: RestResponseProvider {

    var error: Error?
    private var response: HTTPURLResponse?
    var data: Data?
    
    init(response: HTTPURLResponse?,
         data: Data?,
         error: Error?) {
        self.response = response
        self.data = data
        self.error = error
    }

    var httpStatusCode: HTTPStatus {
        guard let code = response?.statusCode,
              let status = HTTPStatus(rawValue: code) else {
                  return .unknown
              }
        return status
    }
    
    var hasData: Bool {
        return data != nil
    }
    
    var hasError: Bool {
        guard let code = response?.statusCode else {
            return false
        }
        
        return code < HTTPStatus.updateSuccess.rawValue || code > HTTPStatus.maxOkStatus.rawValue
    }
    
    var headers: [AnyHashable: Any] {
        guard let allHeaderFields = response?.allHeaderFields else {
            return [:]
        }
        return allHeaderFields
    }
}
