//
//  Account.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 3.05.21.
//

import Foundation

public enum Currency: String, CaseIterable {
    case byn = "BYN"
    case usd = "USD"
    case eur = "EUR"
}

public struct Account {
    var iban: String
    var accountName: String
    var balance: Double
    var currency: String
}
