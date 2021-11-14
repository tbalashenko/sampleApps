//
//  Font+Extension.swift
//  TestAnimationApp
//
//  Created by Татьяна Балашенко on 23.09.21.
//

import SwiftUI

extension Font {
    static func font(ofSize size: CGFloat, weight: Font.Weight) -> Font {
        switch weight {
            case .light:
                return light(ofSize: size)
            case .regular:
                return regular(ofSize: size)
            default:
                return .system(size: size)
        }
    }
    
    static func regular(ofSize size: CGFloat) -> Font {
        .custom("MyriadPro-Regular", size: size)
    }
    
    static func light(ofSize size: CGFloat) -> Font {
        .custom("MyriadPro-Light", size: size)
    }
}
