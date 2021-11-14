//
//  DashboardViewModel.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 24.05.21.
//

import Foundation

class DashboardViewModel {
    var productManger = ProductManager.shared
    var cards: [CardEntity] {
        return productManger.cards
    }
    
    var offers: [OfferEntity] = [OfferEntity(smallText: "Создать", bigText: "КОПИЛКУ"),
                                           OfferEntity(smallText: "Создать", bigText: "КОНТРАКТ")
    ]
    
    var buttons: [DashboardButtonEntity] = [DashboardButtonEntity(text: "ВХОД", color: .darkViolet),
                                            DashboardButtonEntity(text: "КОПИЛКА", color: .orange),
                                            DashboardButtonEntity(text: "КАРТЫ", color: .blue),
                                            DashboardButtonEntity(text: "КОНТРАКТЫ", color: .red),
                                            DashboardButtonEntity(text: "ПРОФИЛЬ", color: .yellow),
                                            DashboardButtonEntity(text: "ТЕМЫ", color: .pink)
    ]
    
    var displayableCardsArray: [CardEntity] = []
    
    var offersArray: [DashboardDisplayable] {
        displayableCardsArray.removeAll()
        for card in cards {
            if card.actions.availableActions[1].isOn {
                displayableCardsArray.append(card)
            }
        }
        return offers + displayableCardsArray
    }
}
