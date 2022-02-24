//
//  FavouriteCollectionViewDataSource.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 23/02/22.
//

import Foundation
import UIKit

final class FavouriteCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var viewModel: FavouriteViewModelProvider?
    
    init(withData viewModel: FavouriteViewModelProvider?) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reusableIdentifier, for: indexPath) as?
                CustomCollectionViewCell else {
            return CustomCollectionViewCell()
        }
        if let photo = viewModel?.photos[indexPath.row], let link = photo.link, let url = URL(string: link) {
            cellItem.configureCell(with: url)
        }
        return cellItem
    }
}
