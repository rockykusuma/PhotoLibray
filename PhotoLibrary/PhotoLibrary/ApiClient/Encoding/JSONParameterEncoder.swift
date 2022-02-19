//
//  JSONParameterEncoder.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    
    /// Encode the parameters to JSON and add appropriate headers once again
    /// - Parameters:
    ///   - urlRequest: URL request passed as reference
    ///   - parameters: header parameters
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkErrorEncoding.encodingFailed
        }
    }
}
