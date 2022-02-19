//
//  ImageService.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

typealias ImageServiceResponseCompletion = (Swift.Result<ImageServiceResponse?, APIError>) -> Void

protocol ImageServiceProtocol {
    func getAccountImages(completion: @escaping ImageServiceResponseCompletion)
    func searchImages(with keyword: String, completion: @escaping ImageServiceResponseCompletion)
    func getFavouriteImages(completion: @escaping ImageServiceResponseCompletion)
}

final class ImageService: RestAPIService, ImageServiceProtocol {
    
    private let router = Router<ImageEndPoint>()
    
    func getAccountImages(completion: @escaping ImageServiceResponseCompletion) {
        router.request(.getAccountImages) { response in
            self.executeResponseEvaluator(ImageServiceResponse.self, response: response) { imageServiceResponse, responseError in
                if let error = responseError {
                    completion(.failure(error))
                }
                completion(.success(imageServiceResponse))
            }
        }
    }
    
    func searchImages(with keyword: String, completion: @escaping ImageServiceResponseCompletion) {
        router.request(.searchImages(keyword: keyword)) { response in
            self.executeResponseEvaluator(ImageServiceResponse.self, response: response) { imageServiceResponse, responseError in
                if let error = responseError {
                    completion(.failure(error))
                }
                completion(.success(imageServiceResponse))
            }
        }
    }
    
    func getFavouriteImages(completion: @escaping ImageServiceResponseCompletion) {
        router.request(.getFavouriteImages) { response in
            self.executeResponseEvaluator(ImageServiceResponse.self, response: response) { imageServiceResponse, responseError in
                if let error = responseError {
                    completion(.failure(error))
                }
                completion(.success(imageServiceResponse))
            }
        }
    }
}
