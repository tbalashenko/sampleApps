//
//  CustomNavigationController.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 13.05.21.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        self.delegate = self
    }
    
    func setupNavigationController() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Base.blue], for: .normal)
        UINavigationBar.appearance().tintColor = UIColor.Base.blue
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = UIColor.Base.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Base.blue, NSAttributedString.Key.font: UIFont.regular(of: 19)]
    }
}

//MARK: - UINavigationControllerDelegate
extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
