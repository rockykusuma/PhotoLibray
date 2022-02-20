//
//  HomeViewModel.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation
import UIKit

protocol HomeViewModelProvider {
    func getAccountImages()
    func favouriteTheImage()
    var photos: [Photo] { get }
    var delegate: HomeViewModelDelegate? { get set }
    func showDetailImageView(image: UIImage?)
    var pageNumber: Int { get set }
    var paginationCompleted: Bool { get }
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadCollectionView()
    func showDetailPage(with viewController: UIViewController)
}

final class HomeViewModel: HomeViewModelProvider {
    
    private var imageClient: ImageClientProvider?
    private (set) var photos: [Photo] = []
    var pageNumber: Int = 0
    private (set) var paginationCompleted = false
    weak var delegate: HomeViewModelDelegate?
    
    init(imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.imageClient?.delegate = self
    }
    
    func getAccountImages() {
        imageClient?.getAccountImages(with: pageNumber)
    }
    
    func favouriteTheImage() {
        
    }
    
    func showDetailImageView(image: UIImage?) {
        guard let image = image else {
            return
        }
        let homeDetailViewModel = HomeDetailViewModel(image: image)
        let homeDetailViewController = HomeDetailViewController(viewModel: homeDetailViewModel)
        delegate?.showDetailPage(with: homeDetailViewController)
    }
}

extension HomeViewModel: ImageClientDelegate {
    
    func didReceiveAccountImages(data: [Photo]) {
        if data.isEmpty {
            paginationCompleted = true
            return
        }
        paginationCompleted = false
        self.photos = data
        delegate?.reloadCollectionView()
    }
    
    func didReceiveFavouriteImages(data: [Photo]) {
        
    }
    
    func didReceiveSearchResultImages(data: [Photo]) {
        
    }
}
