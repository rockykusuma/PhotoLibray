//
//  TabBarController.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        configureTabBar()
        setTabBarItems()
    }
    
    private func configureTabBar() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.orange
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
        
        self.delegate = self
    }
    
    func setTabBarItems() {
        let homeCollectionViewController = HomeCollectionViewController(viewModel: HomeViewModel())
        homeCollectionViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let searchViewController = SearchCollectionViewController(viewModel: SearchViewModel())
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let favouritesViewController = FavouritesViewController(viewModel: FavouriteViewModel())
        favouritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        self.viewControllers = [UINavigationController(rootViewController: homeCollectionViewController),
                                UINavigationController(rootViewController: searchViewController),
                                UINavigationController(rootViewController: favouritesViewController)]
    }
}

extension TabBarController: UITabBarControllerDelegate {    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
