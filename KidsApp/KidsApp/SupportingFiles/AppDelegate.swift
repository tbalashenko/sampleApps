//
//  AppDelegate.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 19.05.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var splashPresenter: SplashPresenter? = SplashPresenter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        splashPresenter?.present()

        let delay: TimeInterval = 3
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationController(rootViewController: DashboardViewController(viewModel: DashboardViewModel()))
        window?.makeKeyAndVisible()
        return true
    }
}
