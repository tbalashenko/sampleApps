//
//  AccountViewModel.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import Foundation

final class DashboardViewModel {
    
    var accountsArray: [Account] = []
    
    func addRandomAccounts(completion: @escaping () -> Void) {
        accountsArray.removeAll()
        for _ in 0...9 {
            var iban: String = ""
            AccountManager.shared.createRandomIBAN { generatedIban in
                iban = generatedIban
            }
            let balance = Double(arc4random()) + (Double(arc4random_uniform(100))/100)
            let currency = Currency.allCases.randomElement()?.rawValue ?? "BYN"
            let accountName = currency == "BYN" ? "Текущий счет" : "Валютный счет"
            accountsArray.append(Account(iban: iban, accountName: accountName, balance: balance.truncatingRemainder(dividingBy: 10000), currency: currency))
        }
        completion()
    }
}
