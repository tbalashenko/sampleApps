//
//  RatesEntry.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 5.10.21.
//

import WidgetKit
import SwiftUI

struct RatesEntry: TimelineEntry {
    let date: Date
    let currencyRateResponse: CurrencyRateResponse
}
