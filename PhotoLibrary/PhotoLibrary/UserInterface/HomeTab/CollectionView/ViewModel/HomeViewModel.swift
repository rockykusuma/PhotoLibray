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
    var photos: [Photo] { get }
    var delegate: HomeViewModelDelegate? { get set }
    func showDetailImageView(index: Int, image: UIImage?)
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
    
    /// Initializer
    ///  - Parameters:
    ///   - imageClient: ImageClientProvider
    init(imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.imageClient?.delegate = self
    }
    
    /// Fetch the Account Images
    func fetchAccountImages() {
        photos.removeAll()
        pageNumber = 0
        isLoading = true
        imageClient?.getAccountImages(with: pageNumber)
    }
    
    /// Fetch more images with pagination
    func fetchImagesMore() {
        if !paginationCompleted && !isLoading {
            isLoading = true
            pageNumber += 1
            imageClient?.getAccountImages(with: pageNumber)
        }
    }

    /// showDetailImageView
    ///  - Parameters:
    ///   - index: Int
    ///   - image: UIImage
    func showDetailImageView(index: Int, image: UIImage?) {
        let photo = photos[index]
        let detailPhoto = DetailPagePhoto(id: photo.id, image: image)
        let homeDetailViewModel = ImageDetailViewModel(photo: detailPhoto, detailScreenFlow: .home)
        let homeDetailViewController = ImageDetailViewController(viewModel: homeDetailViewModel)
        delegate?.showDetailPage(with: homeDetailViewController)
    }
}

extension HomeViewModel: ImageClientDelegate {
    func didReceiveAccountImages(data: [Photo]) {
        self.isLoading = false
        if data.isEmpty {
            paginationCompleted = true
            debugPrint("Total Photos Count -> \(photos.count)")
            delegate?.reloadCollectionView()
            return
        }
        paginationCompleted = false
        photos.append(contentsOf: data)
        delegate?.reloadCollectionView()
    }
}
