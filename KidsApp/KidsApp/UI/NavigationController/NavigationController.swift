//
//  NavigationController.swift
//  KidsApp
//
//  Created by Татьяна Балашенко on 22.05.21.
//

import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        self.delegate = self
    }
    
    private func setupNavigationController() {
        setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - UINavigationControllerDelegate
extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    }
}
