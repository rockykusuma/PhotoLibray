//
//  FavouriteViewModelTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class FavouriteViewModelTests: XCTestCase {
    
    var subjectUnderTest: FavouriteViewModel!
    var error: APIError?
    var expectation: XCTestExpectation?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        subjectUnderTest = nil
        error = nil
        expectation = nil
    }

    func testFetchFavouriteImagesSuccess() throws {
        subjectUnderTest = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        subjectUnderTest.fetchFavouriteImages()
        XCTAssertEqual(subjectUnderTest?.photos.count, 7)
    }
    
    func testFetchFavouriteImagesFailure() throws {
        subjectUnderTest = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Fetch Favourite Images Failure")
        subjectUnderTest.fetchFavouriteImages()
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }

    func testFetchImagesMoreSuccess() throws {
        subjectUnderTest = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        subjectUnderTest.fetchImagesMore()
        XCTAssertEqual(subjectUnderTest?.photos.count, 7)
    }
    
    func testFetchImagesMoreFailure() throws {
        subjectUnderTest = FavouriteViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Fetch More Favourite Images Failure")
        subjectUnderTest.fetchImagesMore()
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
                
    }
}

extension FavouriteViewModelTests: FavouriteViewModelDelegate {
    func reloadCollectionView() {
    }
    
    func showDetailPage(with viewController: UIViewController) {
    }
    
    func didReceiveError(error: APIError) {
        if expectation != nil { // 1
            self.error = error
        }
        expectation?.fulfill()
        expectation = nil
    }
}
