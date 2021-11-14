//
//  UITableView+Ex.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 24.05.21.
//

import UIKit

extension UITableView {
    func registerCell<T:UITableViewCell>(_ cellClass:T.Type) {
        let cellId = cellClass.reuse_id()
        self.register(cellClass.self, forCellReuseIdentifier: cellId)
    }
    
    func dequeueReusableCell<T:UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuse_id(), for: indexPath) as! T
    }
}
