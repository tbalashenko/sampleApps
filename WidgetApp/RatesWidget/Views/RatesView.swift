//
//  RatesView.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import SwiftUI

struct RatesView: View {
    private enum Dimensions {
        static let headerHeight: CGFloat = 45
        static let headerBottomInset: CGFloat = 6
        static let expandedSideSpacing: CGFloat = 20
        static let nonExpandedSideSpacing: CGFloat = 10
    }
    
    let isExpanded: Bool
    let resultCount: Int
    let currencyRateResponse: CurrencyRateResponse
    let ratesType: RatesType
    let selectedCurrencies = ["USD", "EUR", "RUB", "PLN", "GBP"]
    
    var sourceArray: Array<CurrencyEntity>.SubSequence {
        currencyRateResponse.rates
            .filter { selectedCurrencies.contains($0.iso) }
            .prefix(resultCount)
    }
    
    var formattedDate: String {
        let date = DateFormatter.date(fromString: currencyRateResponse.time,
                                      with: ratesType == .card ? .YYYY_MM_dd_HH_mm_ss : .YYYY_MM_dd) ?? Date()
        return DateFormatter.string(fromDate: date,
                                    with: ratesType == .card ? .dd_MM_yyyy_HH_mm : .dd_MM_YYYY ) ?? ""
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.mtbBlue)
                HStack {
                    Text(formattedDate)
                        .font(.regular(ofSize: 14))
                        .foregroundColor(.mtbWhite)
                    if isExpanded {
                        Spacer()
                        Image("logo")
                            .foregroundColor(.mtbWhite)
                    }
                }
                .padding(.horizontal, isExpanded ? Dimensions.expandedSideSpacing : Dimensions.nonExpandedSideSpacing)
            }
            .frame(height: Dimensions.headerHeight)
            .padding(.bottom, Dimensions.headerBottomInset)
            VStack(spacing: 0) {
                ForEach(sourceArray, id: \.id) { currency in
                    VStack(spacing: 0) {
                        if ratesType == .nbrb {
                            NbrbRateRow(currency: currency)
                        } else if isExpanded {
                            LargeRateRow(currency: currency)
                        } else {
                            SmallRateRow(currency: currency)
                        }
                        
                        if currency.id != sourceArray.last?.id, isExpanded {
                            Divider()
                                .padding(.horizontal, Dimensions.expandedSideSpacing)
                        }
                    }
                }
            }
            Spacer()
        }
        .background(Color.mtbWhite)
    }
}
