//
//  CardEntity.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 24.05.21.
//

import UIKit

final class CardEntity: DashboardDisplayable {
    var contractNumber: String
    var productName: String
    var cardNumber: String
    var amount: Double
    var currency: String
    var color: UIColor
    var actions: ProductAction
    
    init(contractNumber: String, productName: String, cardNumber: String, amount: Double, currency: String, actions: ProductAction, color: UIColor) {
        self.contractNumber = contractNumber
        self.productName = productName
        self.cardNumber = cardNumber
        self.amount = amount
        self.currency = currency
        self.actions = actions
        self.color = color
    }
}
