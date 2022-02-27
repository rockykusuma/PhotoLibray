//
//  ImageClientTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 27/02/22.
//

import XCTest
@testable import PhotoLibrary

class ImageClientTests: XCTestCase {
    var imageFavouriteStatus: Bool?
    var favouritePhotos: [FavouritePhoto]?
    var photos: [Photo]?
    var gallery: [Gallery]?
    var error: APIError?
    var expectation: XCTestExpectation?
    var subjectUnderTest: ImageClientProvider!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        subjectUnderTest = nil
        photos = nil
        gallery = nil
        favouritePhotos = nil
        error = nil
        expectation = nil
    }

    func testGetAccountImagesSuccess() throws {
        subjectUnderTest = ImageClient(imageService: MockImageSuccessService())
        subjectUnderTest.delegate = self
        // Act
        expectation = expectation(description: "Get Account Images Success")
        subjectUnderTest.getAccountImages(with: 0)
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(photos)
        XCTAssertEqual(result.count, 50)
    }
    
    func testGetAccountImagesFailure() throws {
        // Arrange
        subjectUnderTest = ImageClient(imageService: MockImageFailureService())
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Get Account Images Failure")
        subjectUnderTest.getAccountImages(with: 0)
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }
    
    func testSearchGallerySuccess() throws {
        subjectUnderTest = ImageClient(imageService: MockImageSuccessService())
        subjectUnderTest.delegate = self
        // Act
        expectation = expectation(description: "Search Images Success")
        subjectUnderTest.searchGallery(with: "cats", pageNumber: 1)
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(gallery)
        XCTAssertEqual(result.count, 60)
    }
    
    func testSearchGalleryFailure() throws {
        // Arrange
        subjectUnderTest = ImageClient(imageService: MockImageFailureService())
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Search Images Failure")
        subjectUnderTest.searchGallery(with: "cats", pageNumber: 1)
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }
    
    func testFavouriteTheImageSuccess() throws {
        subjectUnderTest = ImageClient(imageService: MockImageSuccessService())
        subjectUnderTest.delegate = self
        // Act
        expectation = expectation(description: "Get Favourite Images Success")
        subjectUnderTest.getFavouriteImages(with: 0)
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(favouritePhotos)
        XCTAssertEqual(result.count, 7)
    }
    
    func testGetFavouriteImagesFailure() throws {
        // Arrange
        subjectUnderTest = ImageClient(imageService: MockImageFailureService())
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Get Favourite Images Failure")
        subjectUnderTest.getFavouriteImages(with: 0)
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }
    
    func testGetFavouriteImagesSuccess() throws {
        subjectUnderTest = ImageClient(imageService: MockImageSuccessService())
        subjectUnderTest.delegate = self
        // Act
        expectation = expectation(description: "Favourite Image Success")
        subjectUnderTest.favouriteTheImage(with: "XAWSER")
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(imageFavouriteStatus)
        XCTAssertEqual(result, true)
    }
    
    func testGetFavouriteImagesSuccessTwo() throws {
        subjectUnderTest = ImageClient(imageService: MockImageSuccessServiceTwo())
        subjectUnderTest.delegate = self
        // Act
        expectation = expectation(description: "Favourite Image Success")
        subjectUnderTest.favouriteTheImage(with: "XAWSER")
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(imageFavouriteStatus)
        XCTAssertEqual(result, false)
    }
    
    func testFavouriteTheImageFailure() throws {
        // Arrange
        subjectUnderTest = ImageClient(imageService: MockImageFailureService())
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Favourite Image Failure")
        subjectUnderTest.favouriteTheImage(with: "XAWSER")
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }
}

extension ImageClientTests: ImageClientDelegate {
    func didReceiveAccountImages(data: [Photo]) {
        if expectation != nil { // 1
            self.photos = data
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func didReceiveError(error: APIError) {
        if expectation != nil { // 1
            self.error = error
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func didReceiveSearchResultGallery(data: [Gallery]) {
        if expectation != nil { // 1
            self.gallery = data
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func didReceiveFavouriteImages(data: [FavouritePhoto]) {
        if expectation != nil { // 1
            self.favouritePhotos = data
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func didImageFavourited(status: Bool) {
        if expectation != nil { // 1
            self.imageFavouriteStatus = status
        }
        expectation?.fulfill()
        expectation = nil
    }
}
