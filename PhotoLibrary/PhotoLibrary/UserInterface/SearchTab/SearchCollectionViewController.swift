//
//  SearchViewController.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import UIKit

class SearchCollectionViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    private var viewModel: SearchViewModelProvider
    
    var collectionViewDataSource: SearchCollectionViewDataSource?
    var collectionViewDelegateObject: SearchCollectionViewDelegate?
    
    /// Initializer
    ///  - Parameters:
    ///   - viewModel: SearchViewModelProvider
    init(viewModel: SearchViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: "SearchCollectionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureCollectionView()
        configureUI()
    }
        
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    private func configureUI() {
        self.title = "Search"
        searchBar.placeholder = "Search Image"
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        searchBar.doneAccessory = true
        self.navigationItem.titleView = searchBar
    }
    
    private func configureCollectionView() {
        collectionViewDataSource = SearchCollectionViewDataSource(withData: viewModel)
        collectionViewDelegateObject = SearchCollectionViewDelegate(withData: viewModel)
        collectionView.delegate = self.collectionViewDelegateObject
        collectionView.dataSource = self.collectionViewDataSource
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.invalidateIntrinsicContentSize()
        collectionView.registerNib(GalleryCollectionViewCell.self)
    }
}

extension SearchCollectionViewController: SearchViewModelDelegate {
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showDetailPage(with viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didReceiveError(error: APIError) {
        // Error can be thrown in the form of an Alert or a Banner in the UI
        debugPrint(error.errorDescription ?? "")
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        if searchText.isEmpty {
            viewModel.emptySearchList()
            reloadCollectionView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text ?? "")")
        if let text = searchBar.text, text.count > 2 {
            viewModel.searchInGallery(with: text)
        }
        searchBar.resignFirstResponder()
    }    
}
