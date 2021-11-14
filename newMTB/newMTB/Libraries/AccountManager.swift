//
//  AccountManager.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import Foundation

final class AccountManager {
    static let shared = AccountManager()
    
    func createRandomIBAN(completion: @escaping (String) -> Void) {
        var iban: String = "BY"
        let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        iban.append(String(arc4random_uniform(10)))
        iban.append(String(arc4random_uniform(10)))
        
        for _ in 0...3 {
            iban.append(alphabet[Int(arc4random_uniform(UInt32(alphabet.count)))])
        }
        
        for _ in 0...19 {
            iban.append(String(arc4random_uniform(10)))
        }
        
        completion(iban)
    }
}
