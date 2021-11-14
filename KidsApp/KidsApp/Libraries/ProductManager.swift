//
//  ProductManager.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 25.05.21.
//

import Foundation

final class ProductManager {
    var cards: [CardEntity] = [CardEntity(contractNumber: "1233",
                                          productName: "Белкарт",
                                          cardNumber: "4*** **** **** 1034",
                                          amount: 2000.2332,
                                          currency: "BYN",
                                          actions: ProductAction(availableActions: [CardAction(name: "Отображать сумму", isOn: true),
                                                                                    CardAction(name: "Разместить на главную", isOn: true)],      
                                                                 aboutCard: ["wefwef"]),
                                          color: .orange),
                               CardEntity(contractNumber: "4673",
                                          productName: "Виртуальная",
                                          cardNumber: "4*** **** **** 1035",
                                          amount: 3488.99,
                                          currency: "USD",
                                          actions: ProductAction(availableActions: [CardAction(name: "Отображать сумму", isOn: true),
                                                                                    CardAction(name: "Разместить на главную", isOn: false)],
                                                                 history: ["ijofeijfe", "wfewefef"],
                                                                 aboutCard: ["wefwef"]),
                                          color: .blue),
                               CardEntity(contractNumber: "7373", productName: "Finteam",
                                          cardNumber: "5*** **** **** 5012",
                                          amount: 434.70,
                                          currency: "BYN",
                                          actions: ProductAction(availableActions: [CardAction(name: "Отображать сумму", isOn: false),
                                                                                    CardAction(name: "Разместить на главную", isOn: false),
                                                                                    CardAction(name: "Еще одно действие", isOn: true)
                                          ],
                                          history: ["ijofeijfe", "wfewefef"],
                                          aboutCard: ["wefwef"]),
                                          color: .darkViolet),
                               CardEntity(contractNumber: "983984",
                                          productName: "Виртуальная",
                                          cardNumber: "5*** **** **** 5056",
                                          amount: 3488.99,
                                          currency: "USD",
                                          actions: ProductAction(availableActions: [CardAction(name: "Отображать сумму", isOn: true),
                                                                                    CardAction(name: "Разместить на главную", isOn: true)],
                                                                 history: ["ijofeijfe", "wfewefef"],
                                                                 aboutCard: ["wefwef"]),
                                          color: .pink)
    ]
    
    static let shared = ProductManager()
    
    private init() { }
    
    func updateSettingState(card: CardEntity, setting: Int) {
        for item in cards {
            if card.contractNumber == item.contractNumber {
                item.actions.availableActions[setting].isOn.toggle()
            }
        }
    }
}
