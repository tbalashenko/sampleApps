//
//  NbrbRateRow.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 1.10.21.
//

import SwiftUI
import UIKit

struct NbrbRateRow: View {
    private enum Dimensions {
        static let imageSize: CGSize = CGSize(width: 26, height: 16)
        static let stackSpacing: CGFloat = 12
        static let padding: CGFloat = 20
    }
    
    let currency: CurrencyEntity
    
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
            VStack(alignment: .trailing) {
                Text(currency.formattedRate)
                    .font(.light(ofSize: 16))
                    .foregroundColor(.mtbBlack)
                    .lineLimit(1)
                Text(currency.formattedDeltaRate)
                    .font(.light(ofSize: 10))
                    .foregroundColor(currency.deltaRate > 0 ? .mtbGreen : .mtbRed)
                    .opacity(currency.deltaRate == 0 ? 0 : 1)
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
