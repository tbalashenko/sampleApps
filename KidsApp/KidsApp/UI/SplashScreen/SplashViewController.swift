//
//  ViewController.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 19.05.21.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    private enum Dimensions {
        static let coinWidthHeight = 150
        static let logoImageBottom = 40
        static let logoImageWidth = 220
        static let logoImageHeight = 42
    }
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static let bigCoinImage = UIImage(named: "bigCoin")!
    
    var logoIsHidden: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        coinImage.isHidden = logoIsHidden
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(coinImage)
        view.addSubview(logoImage)
    }
    private func setupConstraints() {
        coinImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(Dimensions.coinWidthHeight)
        }
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Dimensions.logoImageBottom)
            $0.width.equalTo(Dimensions.logoImageWidth)
            $0.height.equalTo(Dimensions.logoImageHeight)
        }
    }
}
