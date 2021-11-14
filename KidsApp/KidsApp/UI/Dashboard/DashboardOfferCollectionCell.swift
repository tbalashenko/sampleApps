//
//  DashboardOfferCollectionCell.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 21.05.21.
//

import UIKit

final class DashboardOfferCollectionCell: UICollectionViewCell {
    private enum Dimensions {
        static let imageTopInset = 24
        static let imageBottomInset = 40
        static let imageLeadingInset = 20
        static let imageHeight = 114
        static let labelsInsetsOffsets = 20
        static let bigLabelTopInset = 6
        static let smallLabelTopInset = 48
        
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var smallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bold(of: 17)
        return label
    }()
    
    private lazy var bigLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bold(of: 48)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var containerView = UIView()
    
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
        containerView.addSubview(imageView)
        containerView.addSubview(smallLabel)
        containerView.addSubview(bigLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.imageTopInset)
            $0.leading.equalToSuperview().inset(Dimensions.imageLeadingInset)
            $0.bottom.equalToSuperview().inset(Dimensions.imageBottomInset)
            $0.height.width.equalTo(Dimensions.imageHeight)
        }
        
        smallLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.smallLabelTopInset)
            $0.leading.equalTo(imageView.snp.trailing).offset(Dimensions.labelsInsetsOffsets)
            $0.trailing.greaterThanOrEqualToSuperview().inset(Dimensions.labelsInsetsOffsets)
        }
        
        bigLabel.snp.makeConstraints {
            $0.top.equalTo(smallLabel.snp.bottom).offset(Dimensions.bigLabelTopInset)
            $0.leading.equalTo(imageView.snp.trailing).offset(Dimensions.labelsInsetsOffsets)
            $0.trailing.equalToSuperview().inset(Dimensions.labelsInsetsOffsets)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        smallLabel.text = nil
        bigLabel.text = nil
    }
    
    public func setupFromEntity(offer: OfferEntity) {
        smallLabel.text = offer.smallText
        bigLabel.text = offer.bigText
    }
}
    
