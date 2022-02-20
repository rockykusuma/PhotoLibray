//
//  Reusable.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 20/02/22.
//

import Foundation
import UIKit

public protocol Reusable: NSObjectProtocol {
    static var reusableIdentifier: String { get }
}

public extension Reusable {
    static var reusableIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Reusable { }
extension UICollectionReusableView: Reusable { }
extension UITableViewHeaderFooterView: Reusable {}

extension UICollectionView {

    // Use this function when you want to register nib.
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let nib = T.nib
        register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
    }

    // Use this function when you want to register a cell created via code.
    func register<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
}

extension UITableView {

    // Use this function when you want to register nib.
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let nib = T.nib
        register(nib, forCellReuseIdentifier: T.reusableIdentifier)
    }

    // Use this function when you want to register a cell created via code.
    func register<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reusableIdentifier)
    }

    /// use this function to register headerFooterView via xib in tableview.
    func registerHeaderFooterViewNib<T: UITableViewHeaderFooterView>(_: T.Type) {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: T.reusableIdentifier)
    }

    /// use this function to register headerFooterView via xib in tableview.
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reusableIdentifier)
    }
}
