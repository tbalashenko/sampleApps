//
//  AtmModel+Ex.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 18.05.21.
//

import Foundation

extension AtmModel {
    convenience init(item: AtmEntity) {
        self.init()
        self.name = item.name
        self.address = item.address
        self.city = item.city
        self.coordinates = item.coordinates
        self.currencies = item.currencies
        self.id = Int64(item.id ?? 0)
        self.isTerminal = item.isTerminal ?? false
        self.time = item.time
    }
}
