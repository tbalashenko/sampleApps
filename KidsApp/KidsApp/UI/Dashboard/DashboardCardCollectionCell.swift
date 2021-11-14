//
//  DashboardCardCollectionCell.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 24.05.21.
//

import UIKit

final class DashboardCardCollectionCell: UICollectionViewCell {
    private enum Dimensions {
        static let amountTopInset = 15
        static let amountLeadingSpace = 20
        static let reloadImageTopInset = 25
        static let reloadImageLeading = 22
        static let currencyTopOffset = 3
        static let productNameTopOffset = 15
        static let productNameLeading =  20
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var amountLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        label.textColor = .white
        label.font = UIFont.medium(of: 70)
        return label
    }()
    
    private lazy var reloadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "reload")
        return imageView
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(of: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(of: 16)
        label.textColor = .white
        return label
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
        containerView.addSubview(reloadImageView)
        containerView.addSubview(currencyLabel)
        containerView.addSubview(productNameLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.amountTopInset)
            $0.leading.equalToSuperview().inset(Dimensions.amountLeadingSpace)
        }
        
        reloadImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.reloadImageTopInset)
            $0.leading.equalTo(amountLabel.snp.trailing).offset(Dimensions.reloadImageLeading)
        }
        
        currencyLabel.snp.makeConstraints {
            $0.top.equalTo(reloadImageView.snp.bottom).offset(Dimensions.currencyTopOffset)
            $0.centerX.equalTo(reloadImageView.snp.centerX)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(amountLabel.snp.bottom).offset(Dimensions.productNameTopOffset)
            $0.leading.equalToSuperview().inset(Dimensions.productNameLeading)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        amountLabel.text = nil
        currencyLabel.text = nil
        productNameLabel.text = nil
    }
    
    public func setupFromEntity(card: CardEntity) {
        amountLabel.text = card.actions.availableActions[0].isOn ? card.amount.formattedWithSeparator : "ТАЙНА"
        currencyLabel.text = card.currency
        productNameLabel.text = card.productName
    }
}
