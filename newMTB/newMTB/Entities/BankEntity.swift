//
//  BankEntity.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 18.05.21.
//

import Foundation

class BankEntity: Codable {
    var address: String?
    var city: String?
    var coordinates: [Double]?
    var name: String?
    var id: Int?
    var time: String?
    
    init(address: String? = nil, city: String? = nil, coordinates: [Double]? = nil, name: String? = nil, id: Int? = nil, time: String? = nil) {
        self.address = address
        self.city = city
        self.coordinates = coordinates
        self.name = name
        self.id = id
        self.time = time
    }
}
