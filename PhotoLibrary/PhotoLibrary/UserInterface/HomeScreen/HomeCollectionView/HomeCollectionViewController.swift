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
    
    private (set) var viewModel: HomeViewModelProvider
    
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
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }
    
    private func configureUI() {
        self.title = "Home"
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
    
    func showDetailPage(with viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
