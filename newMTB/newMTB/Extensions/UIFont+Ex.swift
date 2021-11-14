//
//  UIFont+Ex.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 22.04.21.
//

import UIKit

extension UIFont {
    static func regular(of size: CGFloat) -> UIFont {
        return UIFont(name: "MyriadPro-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func light(of size: CGFloat) -> UIFont {
        return UIFont(name: "MyriadPro-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
}
