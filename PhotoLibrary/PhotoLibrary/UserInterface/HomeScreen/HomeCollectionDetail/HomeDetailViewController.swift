//
//  HomeDetailViewController.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import UIKit

class HomeDetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    private var viewModel: HomeDetailViewModelProvider?
    
    init(viewModel: HomeDetailViewModelProvider) {
        self.viewModel = viewModel
        super.init(nibName: "HomeDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = viewModel?.image
    }
}
