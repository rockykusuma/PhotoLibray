//
//  ImageClientTests.swift
//  PhotoLibraryTests
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import XCTest
@testable import PhotoLibrary

class ImageClientTests: XCTestCase {

    var sut: ImageClient!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAccountImagesSuccess() throws {
        sut = ImageClient(imageService: MockImageSuccessService())
        
    }

}
