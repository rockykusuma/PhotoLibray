//
//  HomeDetailViewController.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {
    
    private enum Constants {
        static let favouriteImage = UIImage(systemName: "suit.heart.fill")
        static let unFavouriteImage = UIImage(systemName: "suit.heart")
    }

    @IBOutlet private weak var imageView: UIImageView!
    
    private (set) var viewModel: ImageDetailViewModelProvider?
    
    /// Initializer
    ///  - Parameters:
    ///   - viewModel: ImageDetailViewModelProvider
    init(viewModel: ImageDetailViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: "ImageDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel?.detailScreenFlow != .search {
            if viewModel?.detailScreenFlow == .favourite {
                updateFavouriteButton(isFavourite: true)
            } else {
                updateFavouriteButton()
            }
        }
        imageView.image = viewModel?.photo?.image
        viewModel?.delegate = self        
    }
    
    private func updateFavouriteButton(isFavourite: Bool = false) {
        var heartImage: UIImage?
        if isFavourite {
            heartImage = Constants.favouriteImage
        } else {
            heartImage = Constants.unFavouriteImage
        }
        let barButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(onButtonClick(_:)))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func onButtonClick(_ sender: UIBarButtonItem) {
        viewModel?.favouriteTheImage()
    }
}

extension ImageDetailViewController: DetailViewModelDelegate {
    func favouritedTheImage(status: Bool) {
        DispatchQueue.main.async {
            self.updateFavouriteButton(isFavourite: status)
            if self.viewModel?.detailScreenFlow == .favourite {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
