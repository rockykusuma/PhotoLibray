//
//  HomeViewModel.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation
import UIKit

protocol HomeViewModelProvider {
    func fetchAccountImages()
    func fetchImagesMore()
    func favouriteTheImage()
    var photos: [Photo] { get }
    var delegate: HomeViewModelDelegate? { get set }
    func showDetailImageView(image: UIImage?)
    var pageNumber: Int { get }
    var paginationCompleted: Bool { get }
    var isLoading: Bool { get }
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadCollectionView()
    func showDetailPage(with viewController: UIViewController)
}

final class HomeViewModel: HomeViewModelProvider {
    
    private var imageClient: ImageClientProvider?
    private (set) var photos: [Photo] = []
    private (set) var pageNumber: Int = 0
    private (set) var paginationCompleted = false
    private (set) var isLoading = false
    weak var delegate: HomeViewModelDelegate?
    
    init(imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.imageClient?.delegate = self
    }
    
    // Fetch the Account Images
    func fetchAccountImages() {
        isLoading = true
        imageClient?.getAccountImages(with: 0)
    }
    
    func fetchImagesMore() {
        if !paginationCompleted && !isLoading {
            isLoading = true
            pageNumber += 1
            imageClient?.getAccountImages(with: pageNumber)
        }
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
        self.isLoading = false
        if data.isEmpty {
            paginationCompleted = true
            debugPrint("Total Photos Count -> \(photos.count)")
            return
        }
        paginationCompleted = false
        photos.append(contentsOf: data)
        delegate?.reloadCollectionView()
    }
    
    func didReceiveFavouriteImages(data: [Photo]) {
        
    }
    
    func didReceiveSearchResultImages(data: [Photo]) {
        
    }
}
