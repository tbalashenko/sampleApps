//
//  Provider.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 5.10.21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RatesEntry {
        RatesEntry(date: Date(), currencyRateResponse: CurrencyRateResponse.mockedResponse)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RatesEntry) -> ()) {
        let entry = RatesEntry(date: Date(), currencyRateResponse: CurrencyRateResponse.mockedResponse)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<RatesEntry>) -> ()) {
        switch context.family {
            case .systemSmall, .systemMedium:
                getRates(type: .card, completion: completion)
            default:
                getRates(type: .nbrb, completion: completion)
        }
    }
    
    func getRates(type: RatesType, completion: @escaping (Timeline<RatesEntry>) -> ()) {
        NetworkManager.shared.request(from: type.url) { (result: Result<CurrencyRateResponse, NetworkManager.ErrorType>) in
            switch result {
                case .success(let response):
                    let currentDate = Date()
                    
                    let entry = RatesEntry(date: currentDate, currencyRateResponse: response)
                    let entries = [entry]
                    
                    let reloadDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
                    
                    let timeline = Timeline(entries: entries, policy: .after(reloadDate))
                    completion(timeline)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
