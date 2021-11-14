//
//  SmallRateRow.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import SwiftUI

struct SmallRateRow: View {
    private enum Dimensions {
        static let stackSpacing: CGFloat = 12
        static let imageSize: CGSize = CGSize(width: 23, height: 14)
        static let padding: CGFloat = 10
    }
    
    var currency: CurrencyEntity
    
    var body: some View {
        HStack(alignment: .top, spacing: Dimensions.stackSpacing) {
            Image(currency.iso)
                .resizable()
                .frame(width: Dimensions.imageSize.width, height: Dimensions.imageSize.height)
            HStack(alignment: .top, spacing: Dimensions.stackSpacing) {
                VStack(alignment: .trailing) {
                    Text(currency.formattedBuy)
                        .font(.light(ofSize: 16))
                        .foregroundColor(.mtbBlack)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    Text(currency.formattedDeltaBuy)
                        .font(.light(ofSize: 10))
                        .foregroundColor(currency.deltaBuy > 0 ? .mtbGreen : .mtbRed)
                        .opacity(currency.deltaBuy == 0 ? 0 : 1)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                }
                VStack(alignment: .trailing) {
                    Text(currency.formattedSell)
                        .font(.light(ofSize: 16))
                        .foregroundColor(.mtbBlack)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    Text(currency.formattedDeltaSell)
                        .font(.light(ofSize: 10))
                        .foregroundColor(currency.deltaSell > 0 ? .mtbGreen : .mtbRed)
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
