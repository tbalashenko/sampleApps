//
//  RatesWidget.swift
//  RatesWidget
//
//  Created by Татьяна Балашенко on 1.10.21.
//

import WidgetKit
import SwiftUI

@main
struct RatesWidget: Widget {
    let kind: String = "RatesWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RatesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Курсы валют")
        .description("Быстрый доступ к актуальным курсам валют")
    }
}
