//
//  CustomNavigationBar.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 27.05.21.
//

import UIKit

final class CustomNavigationBar: UINavigationBar {
    private enum Dimensions {
        static let backButtonLeading = 16
        static let phoneButtonInset = 16
        static let infoButtonOffset = -16
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(nil, action: #selector(UINavigationController.popViewController(animated:)), for: .touchUpInside)
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "phone"), for: .normal)
        return button
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "info"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        addSubviews()
        setupConstraints()
    }
    
    convenience init(viewController: UIViewController, infoAction: Selector, phoneAction: Selector) {
        self.init()
        infoButton.addTarget(viewController, action: infoAction, for: .touchUpInside)
        phoneButton.addTarget(viewController, action: phoneAction, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .white
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.05
    }
    
    private func addSubviews() {
        addSubview(backButton)
        addSubview(infoButton)
        addSubview(phoneButton)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(Dimensions.backButtonLeading)
        }
        
        phoneButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Dimensions.phoneButtonInset)
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(phoneButton.snp.leading).offset(Dimensions.infoButtonOffset)
        }
    }
}
