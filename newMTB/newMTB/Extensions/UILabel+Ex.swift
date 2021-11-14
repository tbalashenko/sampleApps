//
//  UILabel+Ex.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 25.04.21.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor, numberOfLines: Int) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        lineBreakMode = .byTruncatingTail
    }
}
