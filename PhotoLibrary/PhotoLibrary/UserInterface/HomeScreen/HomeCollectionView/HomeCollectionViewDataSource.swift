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
        guard let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reusableIdentifier,
                                                                for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()
        }
        if let photo = viewModel?.photos[indexPath.row] {
            cellItem.configureCell(with: photo)
        }
        return cellItem
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let paginationStatus = viewModel?.paginationCompleted,
           let photosCount = viewModel?.photos.count,
           !paginationStatus && indexPath.row == photosCount - 1 {
            let pageNumber = (viewModel?.pageNumber ?? 0) + 1
            viewModel?.pageNumber = pageNumber
            viewModel?.getAccountImages()
        }
    }
}