//
//  ImageService.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

typealias GalleryServiceResponseCompletion = (Swift.Result<GalleryServiceResponse?, APIError>) -> Void
typealias ImageServiceResponseCompletion = (Swift.Result<ImageServiceResponse?, APIError>) -> Void
typealias FavouriteImageServiceResponseCompletion = (Swift.Result<FavouriteImageServiceResponse?, APIError>) -> Void
typealias FavouriteImageStatusCompletion = (Swift.Result<FavouriteResponse?, APIError>) -> Void

protocol ImageServiceProtocol {
    func getGallery(with pageNumber: Int?, completion: @escaping GalleryServiceResponseCompletion)
    func getAccountImages(with pageNumber: Int?, completion: @escaping ImageServiceResponseCompletion)
    func searchGallery(with keyword: String, pageNumber: Int?, completion: @escaping GalleryServiceResponseCompletion)
    func getFavouriteImages(with pageNumber: Int?, completion: @escaping FavouriteImageServiceResponseCompletion)
    func favouriteTheImage(with id: String, completion: @escaping FavouriteImageStatusCompletion)
}

final class ImageService: RestAPIService, ImageServiceProtocol {
    
    private let router = Router<ImageEndPoint>()
    
    func getGallery(with pageNumber: Int?, completion: @escaping GalleryServiceResponseCompletion) {
        router.request(.getGalleryImages(pageNumber: pageNumber)) { response in
            self.executeResponseEvaluator(GalleryServiceResponse.self, response: response) { imageServiceResponse, responseError in
                if let error = responseError {
                    completion(.failure(error))
                }
                completion(.success(imageServiceResponse))
            }
        }
    }
    
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
    
    func searchGallery(with keyword: String, pageNumber: Int?, completion: @escaping GalleryServiceResponseCompletion) {
        router.request(.searchImages(keyword: keyword, pageNumber: pageNumber)) { response in
            self.executeResponseEvaluator(GalleryServiceResponse.self, response: response) { imageServiceResponse, responseError in
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
