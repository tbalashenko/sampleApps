//
//  UITabBar+Ex.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 22.04.21.
//

import UIKit

extension UITabBarItem {
    convenience init(title: String, imageName: String) {
        self.init(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: imageName))
    }
}
