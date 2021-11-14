//
//  UICollectionViewCell+Ex.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 20.05.21.
//

import UIKit

extension UICollectionView {
    func registerCell<T:UICollectionViewCell>(_ cellClass:T.Type) {
        let cellId = cellClass.reuse_id()
        self.register(cellClass.self, forCellWithReuseIdentifier: cellId)
    }
    
    func dequeueReusableCell<T:UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuse_id(), for: indexPath) as! T
    }
}
