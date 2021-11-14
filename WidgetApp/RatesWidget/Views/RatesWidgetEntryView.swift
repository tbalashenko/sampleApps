//
//  RatesWidgetEntryView.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 5.10.21.
//

import SwiftUI
import WidgetKit

struct RatesWidgetEntryView: View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
            case .systemSmall:
                RatesView(isExpanded: false, resultCount: 2, currencyRateResponse: entry.currencyRateResponse, ratesType: .card)
            case .systemMedium:
                RatesView(isExpanded: true, resultCount: 2, currencyRateResponse: entry.currencyRateResponse, ratesType: .card)
            case .systemLarge, .systemExtraLarge:
                RatesView(isExpanded: true, resultCount: 5, currencyRateResponse: entry.currencyRateResponse, ratesType: .nbrb)
            @unknown default:
                fatalError()
        }
    }
}
