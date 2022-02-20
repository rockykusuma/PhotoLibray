//
//  HomeDetailViewModel.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import Foundation
import UIKit

protocol HomeDetailViewModelProvider {
    func favouriteTheImage()
    var image: UIImage? { get set }
}

final class HomeDetailViewModel: HomeDetailViewModelProvider {
    private var imageClient: ImageClientProvider?
    
    var image: UIImage?
    
    init(image: UIImage, imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.image = image
    }
        
    func favouriteTheImage() {
        
    }
}
