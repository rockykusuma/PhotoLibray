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
    func searchImages(with keyword: String)
    func getFavouriteImages()
    var delegate: ImageClientDelegate? { get set }
}

protocol ImageClientDelegate: AnyObject {
    func didReceiveAccountImages(data: [Photo])
    func didReceiveFavouriteImages(data: [Photo])
    func didReceiveSearchResultImages(data: [Photo])
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
                debugPrint(error.errorDescription ?? "")
            }
        })
    }
    
    func searchImages(with keyword: String) {
        imageService.searchImages(with: keyword) { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                if let photos = response?.data {
                    self.delegate?.didReceiveSearchResultImages(data: photos)
                }
            case .failure(let error):
                debugPrint(error.errorDescription ?? "")
            }
        }
    }
    
    func getFavouriteImages() {
        imageService.getFavouriteImages { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                if let photos = response?.data {
                    self.delegate?.didReceiveFavouriteImages(data: photos)
                }
            case .failure(let error):
                debugPrint(error.errorDescription ?? "")
            }
        }
    }
}
