//
//  HomeCollectionViewControllerTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class HomeCollectionViewControllerTests: XCTestCase {
    
    var sut: HomeCollectionViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let imageClient = ImageClient(imageService: MockImageSuccessService())
        let viewModel = HomeViewModel(imageClient: imageClient)
        sut = HomeCollectionViewController(viewModel: viewModel)
        sut.viewModel.fetchAccountImages()
    }
}
