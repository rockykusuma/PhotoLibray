//
//  SearchViewModel.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation
import UIKit

protocol SearchViewModelProvider {
    func searchInGallery(with keyword: String)
    func fetchMoreInGallery()
    var gallery: [Gallery] { get }
    var delegate: SearchViewModelDelegate? { get set }
    func showDetailImageView(index: Int, image: UIImage?)
    var searchText: String { get set }
    var pageNumber: Int { get }
    var paginationCompleted: Bool { get }
    var isLoading: Bool { get }
    func emptySearchList()
}

protocol SearchViewModelDelegate: AnyObject {
    func reloadCollectionView()
    func showDetailPage(with viewController: UIViewController)
}

final class SearchViewModel: SearchViewModelProvider {
    
    private var imageClient: ImageClientProvider?
    private (set) var gallery: [Gallery] = []
    private (set) var pageNumber: Int = 0
    private (set) var paginationCompleted = false
    private (set) var isLoading = false
    weak var delegate: SearchViewModelDelegate?
    var searchText: String = ""
    
    
    /// Initializer
    ///  - Parameters:
    ///   - imageClient: ImageClientProvider
    init(imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.imageClient?.delegate = self
    }
    
    /// Fetch the Favourite Images
    func searchInGallery(with keyword: String) {
        self.searchText = keyword
        gallery.removeAll()
        pageNumber = 0
        isLoading = true
        imageClient?.searchGallery(with: keyword, pageNumber: pageNumber)
    }
    
    /// Fetch more images using pagination
    func fetchMoreInGallery() {
        if !paginationCompleted && !isLoading {
            isLoading = true
            pageNumber += 1
            imageClient?.searchGallery(with: searchText, pageNumber: pageNumber)
        }
    }
    
    /// showDetailImageView
    ///  - Parameters:
    ///   - index: Int
    ///   - image: UIImage
    func showDetailImageView(index: Int, image: UIImage?) {
        let photo = gallery[index]
        let detailPhoto = DetailPagePhoto(id: photo.id, image: image)
        let homeDetailViewModel = ImageDetailViewModel(photo: detailPhoto, detailScreenFlow: .search)
        let homeDetailViewController = ImageDetailViewController(viewModel: homeDetailViewModel)
        delegate?.showDetailPage(with: homeDetailViewController)
    }
    
    /// Empty Search List
    func emptySearchList() {
        self.searchText = ""
        self.gallery.removeAll()
    }
}

extension SearchViewModel: ImageClientDelegate {
    func didReceiveSearchResultGallery(data: [Gallery]) {
        self.isLoading = false
        if data.isEmpty {
            paginationCompleted = true
            debugPrint("Total Gallery Count -> \(gallery.count)")
            delegate?.reloadCollectionView()
            return
        }
        paginationCompleted = false
        gallery.append(contentsOf: data)
        delegate?.reloadCollectionView()
    }
}
