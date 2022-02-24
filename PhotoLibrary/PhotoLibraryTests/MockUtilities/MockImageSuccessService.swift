//
//  MockImageSuccessService.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation
@testable import PhotoLibrary

final class MockImageSuccessService: RestAPIService, ImageServiceProtocol {
    
    let stubGenerator = StubGenerator()
    
    func getAccountImages(with pageNumber: Int?, completion: @escaping ImageServiceResponseCompletion) {
        let result = stubGenerator.makeImageServiceResponse(ImageServiceResponse.self)
        completion(.success(result))
    }
    
    func searchImages(with keyword: String, completion: @escaping ImageServiceResponseCompletion) {
        let result = stubGenerator.makeImageServiceResponse(ImageServiceResponse.self)
        completion(.success(result))
    }
    
    func getFavouriteImages(with pageNumber: Int?, completion: @escaping FavouriteImageServiceResponseCompletion) {
        let result = stubGenerator.makeFavouriteImageServiceResponse(FavouriteImageServiceResponse.self)
        completion(.success(result))
    }
    
    func favouriteTheImage(with id: String, completion: @escaping FavouriteImageStatusCompletion) {
        let result = stubGenerator.makeFavouriteResponse(FavouriteResponse.self)
        completion(.success(result))
    }
}
