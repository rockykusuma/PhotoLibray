//
//  RestAPIService.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

typealias ResponseCompletion = (_ successResponseData: Data?, _ responseError: APIError?) -> Void

protocol RestAPIServiceProvider {
    func executeResponseEvaluator<T>(_ type: T.Type,
                                     response: RestResponseProvider,
                                     completion: (_ successResponseData: T?, _ responseError: APIError?) -> Void) where T: Decodable
}


class RestAPIService: RestAPIServiceProvider {
    
    /// To parse the service response
    /// - Parameters
    ///   - type: model type to be decoded from the response
    ///   - response: response from the service call
    ///   - completion: completion block
    func executeResponseEvaluator<T>(_ type: T.Type,
                                     response: RestResponseProvider,
                                     completion: (_ successResponseData: T?, _ responseError: APIError?) -> Void) where T: Decodable {
        let responseCompletion: ResponseCompletion = { successResponseData, responseError in
            
            guard let data = successResponseData else {
                completion(nil, responseError)
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self,
                                                         from: data)
                completion(dataModel, nil)
            } catch {
                completion(nil, responseError)
            }
            
        }
        evaluateResponse(response,
                         completion: responseCompletion)
    }
    
    /// To evaluate the response for success and error scenarios
    /// - Parameters:
    ///   - response: response from the service call
    ///   - completion: completion block
    private func evaluateResponse(_ response: RestResponseProvider,
                                  completion: ResponseCompletion) {
        
        guard !response.hasError, response.hasData else {
            let error = decodeError(from: response)
            completion(nil, error)
            
            return
        }
        
        completion(response.data, nil)
    }
    
    /// Decode the error from response data
    /// - Parameter response: response from the service call
    /// - Returns: API error model
    private func decodeError(from response: RestResponseProvider) -> APIError? {
        guard let responseData = response.data else {
            return nil
        }
        do {
            let serviceError = try JSONDecoder().decode(ServiceError.self,
                                                        from: responseData)
            return APIError(errorDescription: serviceError.errorSummary,
                            httpCode: response.httpStatusCode,
                            errorCode: serviceError.errorCode)
        } catch {
            return nil
        }
    }
}
