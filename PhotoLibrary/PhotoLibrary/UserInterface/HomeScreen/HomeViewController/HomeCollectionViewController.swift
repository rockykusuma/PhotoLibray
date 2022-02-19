//
//  HomeCollectionViewController.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 19/02/22.
//

import UIKit

final class HomeCollectionViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    private var viewModel: HomeViewModelProvider = HomeViewModel()
    
    var collectionViewDataSource: HomeCollectionViewDataSource?
    var collectionViewDelegateObject: HomeCollectionViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureUI()
        configureCollectionView()
        viewModel.getAccountImages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    private func configureUI() {
        searchBar.placeholder = "Search Image"
        self.navigationItem.titleView = searchBar
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

extension HomeCollectionViewController: HomeViewModelDelegate {
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
