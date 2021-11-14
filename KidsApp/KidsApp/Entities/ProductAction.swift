//
//  ProductAction.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 1.06.21.
//

import Foundation

final class ProductAction {    
    var availableActions: [CardAction]
    var history: [String]?
    var aboutCard: [String]?
    
    init(availableActions: [CardAction], history: [String]? = nil, aboutCard: [String]? = nil) {
        self.availableActions = availableActions
        self.history = history
        self.aboutCard = aboutCard
    }
}
