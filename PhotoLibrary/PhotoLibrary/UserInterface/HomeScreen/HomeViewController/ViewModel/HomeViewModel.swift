//
//  HomeViewModel.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation

protocol HomeViewModelProvider {
    func getAccountImages()
    func favouriteTheImage()
    var photos: [Photo] { get }
    var delegate: HomeViewModelDelegate? { get set }
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadCollectionView()
}

final class HomeViewModel: HomeViewModelProvider {
    private var imageClient: ImageClientProvider?
    private (set) var photos: [Photo] = []
    weak var delegate: HomeViewModelDelegate?
    
    init(imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.imageClient?.delegate = self
    }
    
    func getAccountImages() {
        imageClient?.getAccountImages()
    }
    
    func favouriteTheImage() {
        
    }
}

extension HomeViewModel: ImageClientDelegate {
    
    func didReceiveAccountImages(data: [Photo]) {
        self.photos = data
        delegate?.reloadCollectionView()
    }
    
    func didReceiveFavouriteImages(data: [Photo]) {
        
    }
    
    func didReceiveSearchResultImages(data: [Photo]) {
        
    }
}
