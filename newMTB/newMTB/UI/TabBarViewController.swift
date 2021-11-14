//
//  TabBarViewController.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 23.04.21.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    let assetsNames: [(String, String)] = [("Главная", "main"),
                                           ("Курсы", "rates"),
                                           ("Создать", "create"),
                                           ("Чат", "chat"),
                                           ("Еще", "more")]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = assetsNames.enumerated().map { (index, assetsName) in
            let viewController: UIViewController
            
            switch index {
                case 0:
                    viewController = DashboardViewController(viewModel: DashboardViewModel())
                    viewController.title = assetsName.0
                case 4:
                    viewController = MoreViewController()
                    viewController.title = assetsName.0
                default:
                    viewController = PlugViewController(titleName: assetsName.0)
            }
            viewController.tabBarItem = UITabBarItem(title: assetsName.0, imageName: assetsName.1)
            return NavigationController(rootViewController: viewController)
        }
        generalInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generalInit() {
        tabBar.tintColor = UIColor.Base.blue
        tabBar.backgroundColor = UIColor.Base.white
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.regular(of: 10)], for: .normal)
    }
}
