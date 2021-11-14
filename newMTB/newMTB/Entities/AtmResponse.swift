//
//  ATM.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import Foundation
import CoreData

struct AtmResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case items
        case serverTime = "server_time"
    }
    
    let items: [AtmEntity]?
    let serverTime: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([AtmEntity].self, forKey: .items)
        serverTime = try values.decodeIfPresent(String.self, forKey: .serverTime)
    }
}
