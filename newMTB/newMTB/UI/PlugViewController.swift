//
//  PlugViewController.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 22.04.21.
//

import UIKit

final class PlugViewController: UIViewController {
    init(titleName: String) {
        super.init(nibName: nil, bundle: nil)
        title = titleName
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
