//
//  HomeDetailViewModel.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import Foundation
import UIKit

protocol ImageDetailViewModelProvider {
    func favouriteTheImage()
    var photo: DetailPagePhoto? { get set }
    var delegate: DetailViewModelDelegate? { get set }
    var detailScreenFlow: DetailScreenFlow? { get }
}

struct DetailPagePhoto {
    let id: String?
    let image: UIImage?
}

enum DetailScreenFlow {
    case home, favourite
}

protocol DetailViewModelDelegate: AnyObject {
    func favouritedTheImage(status: Bool)
}

final class ImageDetailViewModel: ImageDetailViewModelProvider {
   
    private (set) var detailScreenFlow: DetailScreenFlow?
    private var imageClient: ImageClientProvider?
    weak var delegate: DetailViewModelDelegate?
    var photo: DetailPagePhoto?
    
    init(photo: DetailPagePhoto?, detailScreenFlow: DetailScreenFlow?, imageClient: ImageClientProvider = ImageClient()) {
        self.imageClient = imageClient
        self.photo = photo
        self.detailScreenFlow = detailScreenFlow
        self.imageClient?.delegate = self
    }
              
    func favouriteTheImage() {
        guard let id = photo?.id else {
            return
        }
        imageClient?.favouriteTheImage(with: id)
    }
}

extension ImageDetailViewModel: ImageClientDelegate {
    func didImageFavourited(status: Bool) {
        if detailScreenFlow == .home, !status {
            favouriteTheImage()
        } else {
            delegate?.favouritedTheImage(status: status)
        }        
    }
}
