//
//  GalleryCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import UIKit
import Kingfisher

final class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    /// configureCell
    ///  - Parameters:
    ///   - gallery: Gallery
    func configureCell(with gallery: Gallery) {
        var photo: GalleryImage?
        if let images = gallery.images, !images.isEmpty {
            photo = images.first { image in
                if image.type == "image/jpeg" || image.type == "image/png" {
                    return true
                }
                return false
            }
        }
        if let photo = photo, let link = photo.link, let url = URL(string: link) {
            loadImage(url: url)
        } else {
            self.imageView.image = UIImage(named: "noResource")
        }
    }
    
    /// loadImage
    ///  - Parameters:
    ///   - url: URL
    private func loadImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 0)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
