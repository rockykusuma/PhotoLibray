//
//  SearchCollectionViewDelegate.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation
import UIKit

final class SearchCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var viewModel: SearchViewModelProvider?
    
    /// Initializer
    ///  - Parameters:
    ///   - viewModel: SearchViewModelProvider
    init(withData viewModel: SearchViewModelProvider?) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GalleryCollectionViewCell {
            viewModel?.showDetailImageView(index: indexPath.row, image: cell.imageView.image)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.frame.size.height
        if offset > scrollView.contentSize.height {
            viewModel?.fetchMoreInGallery()
        }
    }
}
