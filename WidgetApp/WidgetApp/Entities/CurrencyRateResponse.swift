//
//  CurrencyRateResponse.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import Foundation

final class CurrencyRateResponse: Codable {
    let hasNext: Bool?
    let hasPrev: Bool?
    var rates: [CurrencyEntity]
    let time: String
    
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: time) ?? Date()
    }
    
    var nbrbDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: time) ?? Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case hasNext = "has_next"
        case hasPrev = "has_prev"
        case rates = "rates"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hasNext = try values.decodeIfPresent(Bool.self, forKey: .hasNext) ?? false
        hasPrev = try values.decodeIfPresent(Bool.self, forKey: .hasPrev) ?? false
        rates = try values.decodeIfPresent([CurrencyEntity].self, forKey: .rates) ?? []
        time = try values.decodeIfPresent(String.self, forKey: .time) ?? ""
    }
    
    init(hasNext: Bool, hasPrev: Bool, rates: [CurrencyEntity], time: String) {
        self.hasNext = hasNext
        self.hasPrev = hasPrev
        self.rates = rates
        self.time = time
    }
}

extension CurrencyRateResponse {
    static var mockedResponse: CurrencyRateResponse {
        CurrencyRateResponse(hasNext: false,
                             hasPrev: false,
                             rates: [CurrencyEntity(buy: 2.495,
                                                    deltaBuy: 0,
                                                    deltaRate: 0.0053,
                                                    deltaSell: -0.005,
                                                    iso: "USD",
                                                    rate: 2.5136,
                                                    sell: 2.525),
                                     CurrencyEntity(buy: 2.89,
                                                    deltaBuy: 0.01,
                                                    deltaRate: -0.0038,
                                                    deltaSell: 0.01,
                                                    iso: "EUR",
                                                    rate: 2.9204,
                                                    sell: 2.93),
                                     CurrencyEntity(buy: 3.4,
                                                    deltaBuy: -0.01,
                                                    deltaRate: 0.0169,
                                                    deltaSell: -0.01,
                                                    iso: "RUB",
                                                    rate: 3.4622,
                                                    sell: 3.47),
                                     CurrencyEntity(deltaRate: -0.0361,
                                                    iso: "PLN",
                                                    rate: 6.2854),
                                     CurrencyEntity(deltaRate: 0.44,
                                                    iso: "GBP",
                                                    rate: 3.3823)],
                             time: "2021-09-30 10:35:00")
    }
}
