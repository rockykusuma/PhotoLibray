//
//  FavouriteViewModelTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class FavouriteViewModelTests: XCTestCase {
    
    var sut: FavouriteViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchFavouriteImagesSuccess() throws {
        sut = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        sut.fetchFavouriteImages()
        XCTAssertEqual(sut?.photos.count, 7)
    }
    
    func testFetchFavouriteImagesFailure() throws {
        sut = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        sut.fetchFavouriteImages()
        XCTAssertEqual(sut?.photos.count, 0)
    }

    func testFetchImagesMoreSuccess() throws {
        sut = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        sut.fetchImagesMore()
        XCTAssertEqual(sut?.photos.count, 7)
    }
    
    func testFetchImagesMoreFailure() throws {
        sut = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        sut.fetchImagesMore()
        XCTAssertEqual(sut?.photos.count, 0)
    }
}
