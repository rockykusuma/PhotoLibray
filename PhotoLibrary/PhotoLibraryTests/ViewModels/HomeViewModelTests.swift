//
//  HomeViewModelTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchAccountImagesSuccess() throws {
        sut = HomeViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        sut.fetchAccountImages()
        XCTAssertEqual(sut?.photos.count, 50)
    }
    
    func testFetchAccountImagesFailure() throws {
        sut = HomeViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        sut.fetchAccountImages()
        XCTAssertEqual(sut?.photos.count, 0)
    }

    func testFetchImagesMoreSuccess() throws {
        sut = HomeViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        sut.fetchImagesMore()
        XCTAssertEqual(sut?.photos.count, 50)
    }
    
    func testFetchImagesMoreFailure() throws {
        sut = HomeViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        sut.fetchImagesMore()
        XCTAssertEqual(sut?.photos.count, 0)
    }
}
