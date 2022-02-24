//
//  FavouriteViewModel.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 23/02/22.
//

import Foundation
import UIKit

protocol FavouriteViewModelProvider {
    func fetchFavouriteImages()
    func fetchImagesMore()
    var photos: [FavouritePhoto] { get }
    var delegate: FavouriteViewModelDelegate? { get set }
    func showDetailImageView(index: Int, image: UIImage?)
    var pageNumber: Int { get }
    var paginationCompleted: Bool { get }
    var isLoading: Bool { get }
}

protocol FavouriteViewModelDelegate: AnyObject {
    func reloadCollectionView()
    func showDetailPage(with viewController: UIViewController)
}

final class FavouriteViewModel: FavouriteViewModelProvider {
    
    private var imageClient: ImageClientProvider?
    private (set) var photos: [FavouritePhoto] = []
    private (set) var pageNumber: Int = 0
    private (set) var paginationCompleted = false
    private (set) var isLoading = false
    weak var delegate: FavouriteViewModelDelegate?
    
    /// Initializer
    ///  - Parameters:
    ///   - imageClient: ImageClientProvider
    init(imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.imageClient?.delegate = self
    }
    
    /// Fetch the Favourite Images
    func fetchFavouriteImages() {
        photos.removeAll()
        pageNumber = 0
        isLoading = true
        imageClient?.getFavouriteImages(with: pageNumber)
    }
    
    /// Fetch more images using pagination
    func fetchImagesMore() {
        if !paginationCompleted && !isLoading {
            isLoading = true
            pageNumber += 1
            imageClient?.getFavouriteImages(with: pageNumber)
        }
    }

    /// showDetailImageView
    ///  - Parameters:
    ///   - index: Int
    ///   - image: UIImage
    func showDetailImageView(index: Int, image: UIImage?) {
        let photo = photos[index]
        let detailPhoto = DetailPagePhoto(id: photo.id, image: image)
        let homeDetailViewModel = ImageDetailViewModel(photo: detailPhoto, detailScreenFlow: .favourite)
        let homeDetailViewController = ImageDetailViewController(viewModel: homeDetailViewModel)
        delegate?.showDetailPage(with: homeDetailViewController)
    }
}

extension FavouriteViewModel: ImageClientDelegate {
    func didReceiveFavouriteImages(data: [FavouritePhoto]) {
        self.isLoading = false
        if data.isEmpty {
            paginationCompleted = true
            delegate?.reloadCollectionView()
            debugPrint("Total Photos Count -> \(photos.count)")
            return
        }
        paginationCompleted = false
        photos.append(contentsOf: data)
        delegate?.reloadCollectionView()
    }
}
