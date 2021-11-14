//
//  CurrencyEntity.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import Foundation

public class CurrencyEntity: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case buy = "buy"
        case countIn = "count_in"
        case deltaBuy = "delta_buy"
        case deltaRate = "delta_rate"
        case deltaSell = "delta_sell"
        case iso = "iso"
        case nationalCurrency = "national_currency"
        case rate = "rate"
        case scale = "scale"
        case sell = "sell"
        case backSell = "back_sell"
        case deltaBackSell = "delta_back_sell"
    }
    
    public var id = UUID()
    public var buy: Double?
    public var countIn: String?
    public var deltaBuy: Double
    public var deltaRate: Double
    public var deltaSell: Double
    public var iso: String
    public var nationalCurrency: String?
    public var rate: Double?
    public var scale: Int?
    public var sell: Double?
    public var backSell: Double?
    public var deltaBackSell: Double?
    
    internal init(id: UUID = UUID(),
                  buy: Double? = nil,
                  countIn: String? = nil,
                  deltaBuy: Double = 0,
                  deltaRate: Double = 0,
                  deltaSell: Double = 0,
                  iso: String,
                  nationalCurrency: String? = nil,
                  rate: Double? = nil,
                  scale: Int? = 1,
                  sell: Double? = nil,
                  currencyRateType: CurrencyRateType? = nil) {
        self.id = id
        self.buy = buy
        self.countIn = countIn
        self.deltaBuy = deltaBuy
        self.deltaRate = deltaRate
        self.deltaSell = deltaSell
        self.iso = iso
        self.nationalCurrency = nationalCurrency
        self.rate = rate
        self.scale = scale
        self.sell = sell
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        buy = try values.decodeIfPresent(Double.self, forKey: .buy) ?? 0
        countIn = try values.decodeIfPresent(String.self, forKey: .countIn)
        deltaBuy = try values.decodeIfPresent(Double.self, forKey: .deltaBuy) ?? 0
        deltaRate = try values.decodeIfPresent(Double.self, forKey: .deltaRate) ?? 0
        deltaSell = try values.decodeIfPresent(Double.self, forKey: .deltaSell) ?? 0
        iso = try values.decodeIfPresent(String.self, forKey: .iso) ?? ""
        nationalCurrency = try values.decodeIfPresent(String.self, forKey: .nationalCurrency)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate) ?? 0
        scale = try values.decodeIfPresent(Int.self, forKey: .scale)
        sell = try values.decodeIfPresent(Double.self, forKey: .sell) ?? 0
        
        self.backSell = try values.decodeIfPresent(Double.self, forKey: .backSell)
        
        let deltaSell = try values.decodeIfPresent(Double.self, forKey: .deltaSell)
        self.deltaBackSell = try values.decodeIfPresent(Double.self, forKey: .deltaBackSell)
        
        if let deltaSell = deltaSell {
            self.deltaSell = deltaSell
        } else if let deltaBackSell = self.deltaBackSell {
            self.deltaSell = deltaBackSell
        }
    }
    
    public init(iso: String) {
        self.iso = iso
        self.scale = 1
        self.countIn = nil
        self.nationalCurrency = nil
        self.deltaBuy = 0
        self.deltaRate = 0
        self.deltaSell = 0
    }
    
    public init(iso: String, buy: Double, sell: Double, deltaBuy: Double, deltaSell: Double) {
        self.iso = iso
        self.scale = 1
        self.countIn = nil
        self.nationalCurrency = nil
        self.buy = buy
        self.sell = sell
        self.deltaBuy = deltaBuy
        self.deltaSell = deltaSell
        self.deltaRate = 0
    }
}
