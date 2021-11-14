//
//  String+Extension.swift
//  TestAnimationApp
//
//  Created by Татьяна Балашенко on 23.09.21.
//

import UIKit

public extension String {
    enum SeparatorType: String {
        case space = " "
        case withoutSpace = ""
    }
    
    var replacingCommaWithDot: String {
        return replacingOccurrences(of: ",", with: ".").withoutSpaces
    }
    
    var withoutSpaces: String {
        return String(self.filter { $0 != " " } )
    }
    
    static func grouping(with separator: SeparatorType, decimalNumber: NSDecimalNumber) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = separator.rawValue
        numberFormatter.decimalSeparator = "."
        numberFormatter.groupingSize = 3
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: decimalNumber) ?? ""
    }
}
