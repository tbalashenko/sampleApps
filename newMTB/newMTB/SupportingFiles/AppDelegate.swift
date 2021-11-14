//
//  AppDelegate.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        
        GMSServices.provideAPIKey("AIzaSyBsd9nJka4mGMLg8-KpZo3MphQmnz5pzC0")
        
        NetworkMonitor.shared.startMonitoring()
        
        return true
    }
}

