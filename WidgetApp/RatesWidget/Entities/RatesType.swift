//
//  RatesType.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 1.10.21.
//

import Foundation

enum RatesType {
    case nbrb, card
    
    var url: String {
        switch self {
            case .nbrb:
                return "https://alseda.by/api/v2/info/currency/rates/?bank=50"
            case .card:
                return "https://alseda.by/api/v2/info/currency/rates?forcards=&bank=19"
        }
    }
}
