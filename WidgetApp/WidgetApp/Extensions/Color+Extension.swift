//
//  Color+Extension.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import SwiftUI

private enum Light {
    static let blue = UIColor(hexRGB: 0x0F57A6)
    static let black = UIColor(hexRGB: 0x151616)
    static let gray = UIColor(hexRGB: 0x8B8B8A)
    static let lightGray = UIColor(hexRGB: 0xD7D7D7)
    static let white = UIColor(hexRGB: 0xFFFFFF)
    static let green = UIColor(hexRGB: 0x00AE1E)
    static let red = UIColor(hexRGB: 0xFF0000)
}

private enum Dark {
    static let blue = UIColor(hexRGB: 0x71ACED)
    static let black = UIColor(hexRGB: 0x19191A)
    static let gray = UIColor(hexRGB: 0x8B8B8A)
    static let lightGray = UIColor(hexRGB: 0xD7D7D7)
    static let white = UIColor(hexRGB: 0xFFFFFF)
    static let green = UIColor(hexRGB: 0x41C368)
    static let red = UIColor(hexRGB: 0xFF6A53)
}

extension Color {
    static let mtbBlue = Color(light: Color(Light.blue), dark: Color(Dark.blue))
    static let mtbBlack = Color(light: Color(Light.black), dark: Color(Dark.white))
    static let mtbGray = Color(light: Color(Light.gray), dark: Color(Dark.gray))
    static let mtbLightGray = Color(light: Color(Light.lightGray), dark: Color(Dark.lightGray))
    static let mtbWhite = Color(light: Color(Light.white), dark: Color(Dark.black))
    static let mtbGreen = Color(light: Color(Light.green), dark: Color(Dark.green))
    static let mtbRed = Color(light: Color(Light.red), dark: Color(Dark.red))
}

extension UIColor {
    convenience init(hexRGB: Int, alpha: CGFloat = 1.0) {
        let mask = 0x000000FF
        let red   = CGFloat(Int(hexRGB >> 16) & mask) / 255.0
        let green = CGFloat(Int(hexRGB >> 8) & mask) / 255.0
        let blue  = CGFloat(Int(hexRGB) & mask) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: Dark Mode Extension
extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    return light
                case .dark:
                    return dark
                @unknown default:
                    return light
            }
        }
    }
}

extension Color {
  init(light: Color, dark: Color) {
    self.init(UIColor(light: UIColor(light), dark: UIColor(dark)))
  }
}
