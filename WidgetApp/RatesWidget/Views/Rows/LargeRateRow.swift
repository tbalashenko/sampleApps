//
//  LargeRateRow.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import SwiftUI

struct LargeRateRow: View {
    private enum Dimensions {
        static let stackSpacing: CGFloat = 12
        static let imageSize: CGSize = CGSize(width: 26, height: 16)
        static let buySellStackSpacing: CGFloat = 36
        static let padding: CGFloat = 20
    }
    
    var currency: CurrencyEntity
    
    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .center, spacing: Dimensions.stackSpacing) {
                Image(currency.iso)
                    .resizable()
                    .frame(width: Dimensions.imageSize.width, height: Dimensions.imageSize.height)
                Text(currency.currencyTitle)
                    .font(.light(ofSize: 16))
                    .foregroundColor(.mtbBlack)
                    .padding(.bottom, -2)
            }
            Spacer()
            HStack(alignment: .top, spacing: Dimensions.buySellStackSpacing) {
                VStack(alignment: .trailing) {
                    Text(currency.formattedBuy)
                        .font(.light(ofSize: 16))
                        .foregroundColor(.mtbBlack)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    Text(currency.formattedDeltaBuy)
                        .font(.light(ofSize: 10))
                        .foregroundColor(currency.deltaBuy >= 0 ? .mtbGreen : .mtbRed)
                        .opacity(currency.deltaBuy == 0 ? 0 : 1)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                }
                VStack(alignment: .trailing) {
                    Text(currency.formattedSell)
                        .font(.light(ofSize: 16))
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                        .foregroundColor(.mtbBlack)
                    Text(currency.formattedDeltaSell)
                        .font(.light(ofSize: 10))
                        .foregroundColor(currency.deltaSell >= 0 ? .mtbGreen : .mtbRed)
                        .opacity(currency.deltaSell == 0 ? 0 : 1)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                }
            }
        }
        .background(Color.mtbWhite)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
        .padding(.horizontal, Dimensions.padding)
    }
}
