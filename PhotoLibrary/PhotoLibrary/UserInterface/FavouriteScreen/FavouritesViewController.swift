//
//  FavouritesViewController.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import UIKit

final class FavouritesViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    private var viewModel: HomeViewModelProvider
    
    var collectionViewDataSource: HomeCollectionViewDataSource?
    var collectionViewDelegateObject: HomeCollectionViewDelegate?
    
    init(viewModel: HomeViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: "HomeCollectionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureCollectionView()
//        viewModel.getAccountImages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }
    
    private func configureCollectionView() {
        collectionViewDataSource = HomeCollectionViewDataSource(withData: viewModel)
        collectionViewDelegateObject = HomeCollectionViewDelegate(withData: viewModel)
        collectionView.delegate = self.collectionViewDelegateObject
        collectionView.dataSource = self.collectionViewDataSource
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.invalidateIntrinsicContentSize()
        collectionView.registerNib(CustomCollectionViewCell.self)
    }    
}


extension FavouritesViewController: HomeViewModelDelegate {
    
    func showDetailPage(with viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
