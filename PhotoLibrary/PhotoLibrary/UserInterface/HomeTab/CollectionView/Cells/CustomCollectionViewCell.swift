//
//  CustomCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import UIKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    /// configureCell
    ///  - Parameters:
    ///   - imageUrl: URL
    func configureCell(with imageUrl: URL) {
        loadImage(url: imageUrl)
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
