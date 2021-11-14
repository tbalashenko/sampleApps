//
//  UIFont+Ex.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 19.05.21.
//

import UIKit

extension UIFont {
    static func regular(of size: CGFloat) -> UIFont {
        return UIFont(name: "BloggerSans", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func bold(of size: CGFloat) -> UIFont {
        return UIFont(name: "BloggerSans-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func medium(of size: CGFloat) -> UIFont {
        return UIFont(name: "BloggerSans-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func light(of size: CGFloat) -> UIFont {
        return UIFont(name: "BloggerSans-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
}
