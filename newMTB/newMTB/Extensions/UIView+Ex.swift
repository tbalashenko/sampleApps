//
//  UIView+Ex.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 3.05.21.
//

import UIKit

extension UIView {
    convenience init(color: UIColor) {
        self.init(frame: CGRect())
        backgroundColor = color
    }
    
    public static func reuse_id() -> String {
        return typeName(self)
    }
}
