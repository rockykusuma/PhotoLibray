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
    
    
    var viewModel: HomeViewModelProvider
    
    var collectionViewDataSource: HomeCollectionViewDataSource?
    var collectionViewDelegateObject: HomeCollectionViewDelegate?
    
    /// Initializer
    ///  - Parameters:
    ///   - viewModel: HomeViewModelProvider
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
        configureUI()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAccountImages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    private func configureUI() {
        self.title = "Home"
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
