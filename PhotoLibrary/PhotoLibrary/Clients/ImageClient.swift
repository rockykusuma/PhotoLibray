//
//  ImageClient.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import Foundation
import UIKit

protocol ImageClientProvider {
    func getAccountImages(with pageNumber: Int?)
    func searchGallery(with keyword: String, pageNumber: Int?)
    func getFavouriteImages(with pageNumber: Int?)
    func favouriteTheImage(with id: String)
    var delegate: ImageClientDelegate? { get set }
}

protocol ImageClientDelegate: AnyObject {
    func didReceiveAccountImages(data: [Photo])
    func didReceiveFavouriteImages(data: [FavouritePhoto])
    func didReceiveSearchResultGallery(data: [Gallery])
    func didImageFavourited(status: Bool)
    func didReceiveError(error: APIError)
}

extension ImageClientDelegate {
    func didReceiveAccountImages(data: [Photo]) {}
    func didReceiveFavouriteImages(data: [FavouritePhoto]) {}
    func didReceiveSearchResultGallery(data: [Gallery]) {}
    func didImageFavourited(status: Bool) {}
    func didReceiveError(error: APIError) {}
}

final class ImageClient: ImageClientProvider {
    
    private var imageService: ImageServiceProtocol!
    weak var delegate: ImageClientDelegate?
    
    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
    }
    
    func getAccountImages(with pageNumber: Int?) {
        imageService.getAccountImages(with: pageNumber, completion: { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                if let photos = response?.data {
                    self.delegate?.didReceiveAccountImages(data: photos)
                }
            case .failure(let error):
                self.delegate?.didReceiveError(error: error)
            }
        })
    }
    
    func searchGallery(with keyword: String, pageNumber: Int?) {
        imageService.searchGallery(with: keyword, pageNumber: pageNumber) { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                if let gallery = response?.data {
                    self.delegate?.didReceiveSearchResultGallery(data: gallery)
                }
            case .failure(let error):
                self.delegate?.didReceiveError(error: error)
            }
        }
    }
    
    func getFavouriteImages(with pageNumber: Int?) {
        imageService.getFavouriteImages(with: pageNumber) { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                if let photos = response?.data {
                    self.delegate?.didReceiveFavouriteImages(data: photos)
                }
            case .failure(let error):
                self.delegate?.didReceiveError(error: error)
            }
        }
    }
    
    func favouriteTheImage(with id: String) {
        imageService.favouriteTheImage(with: id) { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                if let status = response?.data {
                    if status == "unfavorited" {
                        self.delegate?.didImageFavourited(status: false)
                    } else {
                        self.delegate?.didImageFavourited(status: true)
                    }
                }
            case .failure(let error):
                self.delegate?.didReceiveError(error: error)
            }
        }
    }
}
