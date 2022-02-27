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
    
    private var viewModel: FavouriteViewModelProvider
    
    var collectionViewDataSource: FavouriteCollectionViewDataSource?
    var collectionViewDelegateObject: FavouriteCollectionViewDelegate?
    
    /// Initializer
    ///  - Parameters:
    ///   - viewModel: FavouriteViewModelProvider
    init(viewModel: FavouriteViewModelProvider) {
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
        title = "Favourites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavouriteImages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    private func configureCollectionView() {
        collectionViewDataSource = FavouriteCollectionViewDataSource(withData: viewModel)
        collectionViewDelegateObject = FavouriteCollectionViewDelegate(withData: viewModel)
        collectionView.delegate = self.collectionViewDelegateObject
        collectionView.dataSource = self.collectionViewDataSource
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.invalidateIntrinsicContentSize()
        collectionView.registerNib(CustomCollectionViewCell.self)
    }    
}


extension FavouritesViewController: FavouriteViewModelDelegate {
    
    func showDetailPage(with viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didReceiveError(error: APIError) {
        // Error can be thrown in the form of an Alert or a Banner in the UI
        debugPrint(error.errorDescription ?? "")
    }
}
