//
//  MockImageFailureService.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation

@testable import PhotoLibrary

final class MockImageFailureService: RestAPIService, ImageServiceProtocol {
    func getGallery(with pageNumber: Int?, completion: @escaping GalleryServiceResponseCompletion) {
        let error = APIError(errorDescription: "No Response from API", httpCode: HTTPStatus.badRequest, errorCode: "0")
        completion(.failure(error))
    }
    
    func searchGallery(with keyword: String, pageNumber: Int?, completion: @escaping GalleryServiceResponseCompletion) {
        let error = APIError(errorDescription: "No Response from API", httpCode: HTTPStatus.badRequest, errorCode: "0")
        completion(.failure(error))
    }
        
    func getAccountImages(with pageNumber: Int?, completion: @escaping ImageServiceResponseCompletion) {
        let error = APIError(errorDescription: "No Response from API", httpCode: HTTPStatus.badRequest, errorCode: "0")
        completion(.failure(error))
    }
    
    func searchImages(with keyword: String, completion: @escaping ImageServiceResponseCompletion) {
        let error = APIError(errorDescription: "No Response from API", httpCode: HTTPStatus.badRequest, errorCode: "0")
        completion(.failure(error))
    }
    
    func getFavouriteImages(with pageNumber: Int?, completion: @escaping FavouriteImageServiceResponseCompletion) {
        let error = APIError(errorDescription: "No Response from API", httpCode: HTTPStatus.badRequest, errorCode: "0")
        completion(.failure(error))
    }
    
    func favouriteTheImage(with id: String, completion: @escaping FavouriteImageStatusCompletion) {
        let error = APIError(errorDescription: "No Response from API", httpCode: HTTPStatus.badRequest, errorCode: "0")
        completion(.failure(error))
    }
}
