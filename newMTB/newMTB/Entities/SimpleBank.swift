//
//  SimpleBank.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 11.05.21.
//

import Foundation

enum BankKind {
    case atm
    case filial
}

struct SimpleBank {
    var name: String
    var address: String
    var distance: Double?
    var coordinates: [Double]
    var kind: BankKind?
}
