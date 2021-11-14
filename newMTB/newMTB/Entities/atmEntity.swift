//
//  atmEntity.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 18.05.21.
//

import Foundation

final class AtmEntity: BankEntity {
    enum CodingKeys: String, CodingKey {
        case currencies, metro
        case isTerminal = "is_terminal"
    }
    
    var currencies: [String]?
    var isTerminal: Bool?

    init(address: String? = nil, city: String? = nil, coordinates: [Double]? = nil, name: String? = nil, id: Int? = nil, time: String? = nil, currencies: [String]? = nil, isTerminal: Bool? = nil) {
        self.currencies = currencies
        self.isTerminal = isTerminal
        super.init(address: address, city: city, coordinates: coordinates, name: name, id: id, time: time)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.currencies = try values.decode([String].self, forKey: .currencies)
        self.isTerminal = try values.decode(Bool.self, forKey: .isTerminal)
        try super.init(from: decoder)
    }
}
