//
//  FilialModel+Ex.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 18.05.21.
//

import Foundation

extension FilialModel {
    convenience init(item: FilialEntity) {
        self.init()
        self.name = item.name
        self.address = item.address
        self.city = item.city
        self.coordinates = item.coordinates
        self.id = Int64(item.id ?? 0)
        self.time = item.time
        self.phones = item.phones
        self.services = item.services
        self.kind = Int64(item.kind ?? 0)
    }
}
