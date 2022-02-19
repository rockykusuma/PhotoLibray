//
//  Router.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

typealias NetworkRouterCompletion = (RestResponseProvider) -> Void

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    /// To make the REST API call
    /// - Parameters:
    ///   - route: endpoint for creating the request
    ///   - completion: completion block
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                if error == nil {
                    completion(RestResponse(response: response as? HTTPURLResponse, data: data, error: nil))
                } else {
                    completion(RestResponse(response: nil, data: nil, error: error))
                }
            })
        } catch {
            completion(RestResponse(response: nil, data: nil, error: error))
        }
        self.task?.resume()
    }
    
    /// Cancel the URLSessionTask
    func cancel() {
        self.task?.cancel()
    }
    
    /// To build the URLRequest using the EndPoint info
    /// - Parameter route: endpoint for creating the request
    /// - Returns:  Service request
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    /// To encode and add headers for the service request
    /// - Parameters:
    ///   - bodyParameters: body parameters
    ///   - bodyEncoding: encoding required for the service request
    ///   - urlParameters: url parameters
    ///   - request: request passed as reference type
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    /// To add the additional headers for the service request
    /// - Parameters:
    ///   - additionalHeaders: additional headers
    ///   - request: request passed as reference type
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
