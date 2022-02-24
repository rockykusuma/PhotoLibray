//
//  ImageDetailViewControllerTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class ImageDetailViewControllerTests: XCTestCase {
    
    var sut: ImageDetailViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testOnButtonClick() throws {
        let imageClient = ImageClient(imageService: MockImageSuccessService())
        let photo = DetailPagePhoto(id: "xKYvtNZ", image: nil)
        let viewModel = ImageDetailViewModel(photo: photo, detailScreenFlow: .home, imageClient: imageClient)
        sut = ImageDetailViewController(viewModel: viewModel)
        sut.viewModel?.favouriteTheImage()
    }
}
