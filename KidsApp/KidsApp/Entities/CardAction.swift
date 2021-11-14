//
//  CardAction.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 1.06.21.
//

import Foundation

final class CardAction: Equatable {
    var name: String
    var isOn: Bool
    
    init(name: String, isOn: Bool) {
        self.name = name
        self.isOn = isOn
    }
    
    static func == (lhs: CardAction, rhs: CardAction) -> Bool {
        return lhs.name == rhs.name
    }
}
