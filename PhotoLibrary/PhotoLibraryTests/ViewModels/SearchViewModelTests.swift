//
//  SearchViewModelTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSearchInGallerySuccess() throws {
        sut = SearchViewModel(imageClient: ImageClient(imageService: MockImageSuccessService()))
        sut.searchInGallery(with: "dogs")
        XCTAssertEqual(sut?.gallery.count, 60)
    }
    
    func testSearchInGalleryFailure() throws {
        sut = SearchViewModel(imageClient: ImageClient(imageService: MockImageFailureService()))
        sut.searchInGallery(with: "dogs")
        XCTAssertEqual(sut?.gallery.count, 0)
    }
}
