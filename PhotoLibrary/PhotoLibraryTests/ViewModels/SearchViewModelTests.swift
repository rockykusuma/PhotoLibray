//
//  SearchViewModelTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class SearchViewModelTests: XCTestCase {
    
    var subjectUnderTest: SearchViewModelProvider!
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

    func testSearchInGallerySuccess() throws {
        subjectUnderTest = SearchViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        subjectUnderTest.searchInGallery(with: "dogs")
        XCTAssertEqual(subjectUnderTest?.gallery.count, 60)
        XCTAssertEqual(subjectUnderTest?.searchText, "dogs")
    }
    
    func testSearchInGalleryFailure() throws {
        subjectUnderTest = SearchViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Search Images Failure")
        subjectUnderTest.searchInGallery(with: "dogs")
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }
    
    func testSearchImagesMoreSuccess() throws {
        subjectUnderTest = SearchViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        subjectUnderTest.delegate = self
        subjectUnderTest.fetchMoreInGallery()
        XCTAssertEqual(subjectUnderTest?.gallery.count, 60)
    }
    
    func testFetchImagesMoreFailure() throws {
        subjectUnderTest = SearchViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        subjectUnderTest.delegate = self
        
        // Act
        expectation = expectation(description: "Search More Images Failure")
        subjectUnderTest.fetchMoreInGallery()
        
        // Assert
        waitForExpectations(timeout: 0.1)
        
        let result = try XCTUnwrap(error)
        XCTAssertEqual(result.errorDescription, "No Response from API")
    }
    
    func testEmptySearchList() {
        subjectUnderTest = SearchViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        subjectUnderTest.delegate = self
        
        subjectUnderTest.emptySearchList()
        XCTAssertEqual(subjectUnderTest?.gallery.count, 0)
        XCTAssertEqual(subjectUnderTest?.searchText, "")
    }
}

extension SearchViewModelTests: SearchViewModelDelegate {
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
