//
//  OfferEntity.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 24.05.21.
//

import Foundation

final class OfferEntity {
    var smallText: String
    var bigText: String
    
    init(smallText: String, bigText: String) {
        self.smallText = smallText
        self.bigText = bigText
    }
}

extension OfferEntity: DashboardDisplayable { }
