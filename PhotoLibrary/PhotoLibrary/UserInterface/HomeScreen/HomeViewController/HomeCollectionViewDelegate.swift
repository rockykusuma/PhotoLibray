//
//  HomeCollectionViewDelegate.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import Foundation
import UIKit

final class HomeCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var viewModel: HomeViewModelProvider?
    
    init(withData viewModel: HomeViewModelProvider?) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)        
    }
}
