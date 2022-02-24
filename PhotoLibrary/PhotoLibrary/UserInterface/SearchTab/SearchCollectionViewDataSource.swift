//
//  SearchCollectionViewDataSource.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import Foundation
import UIKit

final class SearchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var viewModel: SearchViewModelProvider?
    
    /// Initializer
    ///  - Parameters:
    ///   - viewModel: SearchViewModelProvider
    init(withData viewModel: SearchViewModelProvider?) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.gallery.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reusableIdentifier, for: indexPath) as?
                GalleryCollectionViewCell else {
            return GalleryCollectionViewCell()
        }
        if let gallery = viewModel?.gallery[indexPath.row] {
            cellItem.configureCell(with: gallery)
        }
        return cellItem
    }
}
