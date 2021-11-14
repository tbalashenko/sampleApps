//
//  CardsCollectionViewCell.swift
//  KidsApp
//
//  Created by Татьяна Балашенко on 23.05.21.
//

import UIKit

final class CardsCollectionViewCell: UICollectionViewCell {
    private enum Dimensions {
        static let amountTopInset = 22
        static let amountLeadingInsets = 26
        static let reloadImageTopInset = 26
        static let reloadImageLeadingOffset = 16
        static let checkImageTopOffset = 32
        static let productNameTopOffset = 29
        static let productNameLeadingOffset = 24
        static let cardNumberLabelTopOffset = 8
        static let cardNumberLabelBottomInset = 36
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.7
        view.layer.cornerRadius = 60
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.orange.cgColor
        return view
    }()
    
    private lazy var amountLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        label.font = UIFont.medium(of: 56)
        label.textColor = .white
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(of: 17)
        label.textColor = .white
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(of: 30)
        label.textColor = .white
        return label
    }()
    
    private lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(of: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var reloadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "reload")
        return imageView
    }()
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(amountLabel)
        containerView.addSubview(checkImageView)
        containerView.addSubview(reloadImageView)
        containerView.addSubview(currencyLabel)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(cardNumberLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.amountTopInset)
            $0.leading.equalToSuperview().inset(Dimensions.amountLeadingInsets)
        }
        
        reloadImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.reloadImageTopInset)
            $0.leading.equalTo(amountLabel.snp.trailing).offset(Dimensions.reloadImageLeadingOffset)
        }
        
        currencyLabel.snp.makeConstraints {
            $0.top.equalTo(reloadImageView.snp.bottom)
            $0.centerX.equalTo(reloadImageView.snp.centerX)
        }
        
        checkImageView.snp.makeConstraints {
            $0.top.equalTo(amountLabel.snp.bottom).offset(Dimensions.checkImageTopOffset)
            $0.leading.equalTo(amountLabel.snp.leading)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(amountLabel.snp.bottom).offset(Dimensions.productNameTopOffset)
            $0.leading.equalTo(checkImageView.snp.trailing).offset(Dimensions.productNameLeadingOffset)
        }
        
        cardNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(productNameLabel.snp.leading)
            $0.top.equalTo(productNameLabel.snp.bottom).offset(Dimensions.cardNumberLabelTopOffset)
            $0.bottom.equalToSuperview().inset(Dimensions.cardNumberLabelBottomInset)
        }
    }
    
    override func prepareForReuse() {
        amountLabel.text = nil
        currencyLabel.text = nil
        productNameLabel.text = nil
        cardNumberLabel.text = nil
        containerView.backgroundColor = nil
        containerView.layer.shadowColor = nil
    }
    
    public func setupFromEntity(card: CardEntity) {
        currencyLabel.text = card.currency
        productNameLabel.text = card.productName
        cardNumberLabel.text = card.cardNumber
        amountLabel.text = card.actions.availableActions[0].isOn ? card.amount.formattedWithSeparator : "ТАЙНА"
        containerView.backgroundColor = card.color
        containerView.layer.shadowColor = card.color.cgColor
    }
}
