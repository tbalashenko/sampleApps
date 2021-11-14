//
//  CardsViewModel.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 24.05.21.
//

import Foundation

final class CardsViewModel {
    var productManger = ProductManager.shared
    var cards: [CardEntity] {
        return productManger.cards
    }
}
