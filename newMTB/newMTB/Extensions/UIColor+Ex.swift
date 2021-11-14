//
//  UIColor+Ex.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 22.04.21.
//

import UIKit

extension UIColor {
    struct Base {
        static let blue = UIColor(hexRGB: 0x0F57A6)
        static let black = UIColor(hexRGB: 0x151616)
        static let gray = UIColor(hexRGB: 0x8B8B8A)
        static let lightGray = UIColor(hexRGB: 0xD7D7D7)
        static let white = UIColor(hexRGB: 0xFFFFFF)
    }
    
    convenience init(hexRGB: Int, alpha: CGFloat = 1.0) {
        let mask = 0x000000FF
        let red   = CGFloat(Int(hexRGB >> 16) & mask) / 255.0
        let green = CGFloat(Int(hexRGB >> 8) & mask) / 255.0
        let blue  = CGFloat(Int(hexRGB) & mask) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
