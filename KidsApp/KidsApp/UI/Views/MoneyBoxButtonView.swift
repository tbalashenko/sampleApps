//
//  MoneyBoxButtonView.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 27.05.21.
//

import UIKit

class MoneyBoxButtonView: UIView {
    private enum Dimensions {
        static let moneyBoxSideInsets = 20
        static let moneyBoxBottomInset = 34
        static let moneyBoxEllipseLeadingInset = 18
        static let moneyBoxEllipseHeightWidth = 52
        static let moneyBoxLabelInset = 16
    }
    
    private lazy var moneyBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "Пополнить копилку"
        label.textColor = .white
        label.font = UIFont.regular(of: 20)
        return label
    }()
    
    private lazy var moneyBoxEllipseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ellipse")
        return imageView
    }()
    
    private lazy var moneyBoxButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var moneyBoxCardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "card")
        imageView.tintColor = .orange
        return imageView
    }()
    
    lazy var moneyBoxContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 43
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(moneyBoxContainerView)
        moneyBoxContainerView.addSubview(moneyBoxEllipseImage)
        moneyBoxContainerView.addSubview(moneyBoxLabel)
        moneyBoxEllipseImage.addSubview(moneyBoxCardImage)
        moneyBoxContainerView.addSubview(moneyBoxButton)
    }
    
    private func setupConstraints() {
        
        moneyBoxContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Dimensions.moneyBoxSideInsets)
            $0.bottom.equalToSuperview().inset(Dimensions.moneyBoxBottomInset)
        }
        
        moneyBoxEllipseImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(Dimensions.moneyBoxEllipseLeadingInset)
            $0.height.width.equalTo(Dimensions.moneyBoxEllipseHeightWidth)
        }
        
        moneyBoxLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalTo(moneyBoxEllipseImage.snp.trailing).offset(Dimensions.moneyBoxLabelInset)
        }
        
        moneyBoxCardImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        moneyBoxButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
