//
//  ImageService.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

typealias ImageServiceResponseCompletion = (Swift.Result<ImageServiceResponse?, APIError>) -> Void
typealias FavouriteImageServiceResponseCompletion = (Swift.Result<FavouriteImageServiceResponse?, APIError>) -> Void
typealias FavouriteImageStatusCompletion = (Swift.Result<FavouriteResponse?, APIError>) -> Void

protocol ImageServiceProtocol {
    func getAccountImages(with pageNumber: Int?, completion: @escaping ImageServiceResponseCompletion)
    func searchImages(with keyword: String, completion: @escaping ImageServiceResponseCompletion)
    func getFavouriteImages(with pageNumber: Int?, completion: @escaping FavouriteImageServiceResponseCompletion)
    func favouriteTheImage(with id: String, completion: @escaping FavouriteImageStatusCompletion)
}

final class ImageService: RestAPIService, ImageServiceProtocol {
    
    private let router = Router<ImageEndPoint>()
    
    func getAccountImages(with pageNumber: Int?, completion: @escaping ImageServiceResponseCompletion) {
        router.request(.getAccountImages(pageNumber: pageNumber)) { response in
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
    
    func getFavouriteImages(with pageNumber: Int?, completion: @escaping FavouriteImageServiceResponseCompletion) {
        router.request(.getFavouriteImages(pageNumber: pageNumber, sort: .newest)) { response in
            self.executeResponseEvaluator(FavouriteImageServiceResponse.self, response: response) { imageServiceResponse, responseError in
                if let error = responseError {
                    completion(.failure(error))
                }
                completion(.success(imageServiceResponse))
            }
        }
    }
    
    func favouriteTheImage(with id: String, completion: @escaping FavouriteImageStatusCompletion) {
        router.request(.favouriteTheImage(id: id)) { response in
            self.executeResponseEvaluator(FavouriteResponse.self, response: response) { response, responseError in
                if let error = responseError {
                    completion(.failure(error))
                }
                completion(.success(response))
            }
        }
    }
}
