//
//  WidgetAppApp.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import SwiftUI
import WidgetKit

@main
struct WidgetAppApp: App {
    
    init() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
