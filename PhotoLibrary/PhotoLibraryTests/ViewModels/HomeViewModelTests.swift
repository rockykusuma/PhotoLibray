//
//  HomeViewModelTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class HomeViewModelTests: XCTestCase {

    var subjectUnderTest: HomeViewModelProvider!
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

    func testFetchAccountImagesSuccess() throws {
        subjectUnderTest = HomeViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        subjectUnderTest.delegate = self
        
        subjectUnderTest.fetchAccountImages()
        
        XCTAssertEqual(subjectUnderTest?.photos.count, 50)
    }
    
    func testFetchAccountImagesFailure() throws {
        subjectUnderTest = HomeViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Fetch Account Images Failure")
        subjectUnderTest.fetchAccountImages()
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }

    func testFetchImagesMoreSuccess() throws {
        subjectUnderTest = HomeViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        subjectUnderTest.delegate = self
        subjectUnderTest.fetchImagesMore()
        XCTAssertEqual(subjectUnderTest?.photos.count, 50)
    }
    
    func testFetchImagesMoreFailure() throws {
        subjectUnderTest = HomeViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Fetch More Images Failure")
        subjectUnderTest.fetchImagesMore()
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }
}

extension HomeViewModelTests: HomeViewModelDelegate {
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
