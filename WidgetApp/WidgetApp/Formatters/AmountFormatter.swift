//
//  AmountFormatter.swift
//  TestAnimationApp
//
//  Created by Татьяна Балашенко on 23.09.21.
//

import Foundation

open class AmountFormatter {
    // use this constaint to show as many digits as possible
    static let MaximumDigits = 20
    
    public var minDigits = 2
    public var maxDigits = 2
    public var grouping = true
    
    static public var shared = AmountFormatter()

    static public func string(_ amount: Double, currency: Currency? = nil, grouping: Bool? = nil, minDigits: Int? = nil, maxDigits: Int? = nil, roundingMode: NumberFormatter.RoundingMode = .halfEven) -> String {
        let decimalValue = NSDecimalNumber(value: amount)

        return AmountFormatter.shared.string(decimalValue, currency: currency, grouping: grouping, minDigits: minDigits, maxDigits: maxDigits, roundingMode: roundingMode)
    }
    
    open func string(_ amount: NSDecimalNumber, currency: Currency? = nil, grouping: Bool? = nil, minDigits: Int? = nil, maxDigits: Int? = nil, roundingMode: NumberFormatter.RoundingMode = .halfEven) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.roundingMode = roundingMode
        
        let shared = AmountFormatter.shared
        formatter.groupingSeparator = (grouping ?? shared.grouping) ? " " : ""
        formatter.minimumFractionDigits = minDigits ?? shared.minDigits
        formatter.maximumFractionDigits = maxDigits ?? shared.maxDigits
        
        let validAmountNumber = NSDecimalNumber.notANumber.isEqual(to: amount) ? NSDecimalNumber.zero : amount
        var result = formatter.string(from: validAmountNumber) ?? NSDecimalNumber.zero.stringValue
        
        if let currency = currency {
            result = result + " " + currency.iso
        }
        
        return result
    }
}
