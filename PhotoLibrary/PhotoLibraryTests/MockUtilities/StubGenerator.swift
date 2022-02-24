//
//  StubGenerator.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation

class StubGenerator {
            
    func makeImageServiceResponse<T: Decodable>(_ expectedType: T.Type) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let mappingResponse = FileUtility.objectFromJsonFile(T.self, fileNameBase: "ImageServiceResponse", bundle: bundle) else {
            return nil
        }
        return mappingResponse
    }
    
    func makeFavouriteImageServiceResponse<T: Decodable>(_ expectedType: T.Type) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let mappingResponse = FileUtility.objectFromJsonFile(T.self, fileNameBase: "FavouriteImageServiceResponse", bundle: bundle) else {
            return nil
        }
        return mappingResponse
    }
    
    func makeFavouriteResponse<T: Decodable>(_ expectedType: T.Type) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let mappingResponse = FileUtility.objectFromJsonFile(T.self, fileNameBase: "FavouriteResponse", bundle: bundle) else {
            return nil
        }
        return mappingResponse
    }
}
