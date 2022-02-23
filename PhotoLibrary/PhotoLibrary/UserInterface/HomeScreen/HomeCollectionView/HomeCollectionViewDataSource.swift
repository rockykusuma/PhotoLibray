//
//  HomeCollectionViewDataSource.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import Foundation
import UIKit

final class HomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var viewModel: HomeViewModelProvider?
    
    init(withData viewModel: HomeViewModelProvider?) {
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
        if let photo = viewModel?.photos[indexPath.row] {
            cellItem.configureCell(with: photo)
        }
        return cellItem
    }
}
