//
//  FilialEntity.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 18.05.21.
//

import Foundation

final class FilialEntity: BankEntity {
    enum CodingKeys: String, CodingKey {
        case kind, phones, services
        case servicesForCorp = "services_for_corp"
        case servicesForIndividuals = "services_for_individuals"
    }
    
    var kind: Int?
    var phones: String?
    var services: [String]?
    var servicesForCorp: [String]?
    var servicesForIndividuals: [String]?
    
    init(address: String? = nil, city: String? = nil, coordinates: [Double]? = nil, name: String? = nil, id: Int? = nil, time: String? = nil, kind: Int? = nil, phones: String? = nil, services: [String]? = nil, servicesForCorp: [String]? = nil, servicesForIndividuals: [String]? = nil) {
        self.kind = kind
        self.phones = phones
        self.services = services
        self.servicesForCorp = servicesForCorp
        self.servicesForIndividuals = servicesForIndividuals
        super.init(address: address, city: city, coordinates: coordinates, name: name, id: id, time: time)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(Int.self, forKey: .kind)
        phones = try values.decodeIfPresent(String.self, forKey: .phones)
        services = try values.decodeIfPresent([String].self, forKey: .services)
        servicesForCorp = try values.decodeIfPresent([String].self, forKey: .servicesForCorp)
        servicesForIndividuals = try values.decodeIfPresent([String].self, forKey: .servicesForIndividuals)
        try super.init(from: decoder)
    }
}
