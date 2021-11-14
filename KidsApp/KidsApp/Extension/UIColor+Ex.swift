//
//  UIColor+Ex.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 19.05.21.
//

import UIKit

extension UIColor {
    static let blue = UIColor(hexRGB: 0x4966FF)       // #4966FF
    static let white = UIColor(hexRGB: 0xFFFFFF)      // #FFFFFF
    static let orange = UIColor(hexRGB: 0xF7AB0F)     // #F7AB0F
    static let yellow = UIColor(hexRGB: 0xFFC736)     // #FFC736
    static let red = UIColor(hexRGB: 0xFF6737)        // #FF6737
    static let pink = UIColor(hexRGB: 0xFF43A8)       // #FF43A8
    static let darkViolet = UIColor(hexRGB: 0xAC6FFC) // #AC6FFC
    static let gray = UIColor(hexRGB: 0xD4D4D4)       // #D4D4D4
    static let textGray = UIColor(hexRGB: 0x8F8F8F)   // #8F8F8F
    
    convenience init(hexRGB: Int, alpha: CGFloat = 1.0) {
        let mask = 0x000000FF
        let red   = CGFloat(Int(hexRGB >> 16) & mask) / 255.0
        let green = CGFloat(Int(hexRGB >> 8) & mask) / 255.0
        let blue  = CGFloat(Int(hexRGB) & mask) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
