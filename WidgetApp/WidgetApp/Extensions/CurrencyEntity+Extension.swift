//
//  CurrencyEntity+Extension.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 5.10.21.
//

import Foundation

extension CurrencyEntity {
    var formattedBuy: String {
        AmountFormatter.string(buy ?? 0, grouping: true, minDigits: 4, maxDigits: 4)
    }
    
    var formattedDeltaBuy: String {
        (deltaBuy > 0 ? "+" : "") + AmountFormatter.string(deltaBuy, grouping: true, minDigits: 4, maxDigits: 4)
    }
    
    var formattedSell: String {
        AmountFormatter.string(sell ?? 0, grouping: true, minDigits: 4, maxDigits: 4)
    }
    
    var formattedDeltaSell: String {
        (deltaSell > 0 ? "+" : "") + AmountFormatter.string(deltaSell, grouping: true, minDigits: 4, maxDigits: 4)
    }
    
    var formattedRate: String {
        AmountFormatter.string(rate ?? 0, grouping: true, minDigits: 4, maxDigits: 4)
    }
    
    var formattedDeltaRate: String {
        (deltaRate > 0 ? "+" : "") + AmountFormatter.string(deltaRate, grouping: true, minDigits: 4, maxDigits: 4)
    }
    
    var currencyTitle: String {
        String(scale ?? 1) + " " + iso
    }
}
