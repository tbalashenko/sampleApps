//
//  BankListViewCell.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 11.05.21.
//

import UIKit

final class BankListViewCell: UITableViewCell {
    private enum Dimensions {
        static let topBottomInsets = 24
        static let leadingTrailingInsets = 16
        static let topOffsets = 8
    }
    
    private lazy var bankNameLabel = UILabel(font: UIFont.regular(of: 20), textColor: UIColor.Base.black, numberOfLines: 0)
    
    private lazy var bankAddressLabel = UILabel(font: UIFont.light(of: 16), textColor: UIColor.Base.black, numberOfLines: 0)
    
    private lazy var bankDistanceLabel = UILabel(font: UIFont.light(of: 16), textColor: UIColor.Base.gray, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.Base.white
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        contentView.addSubview(bankNameLabel)
        contentView.addSubview(bankAddressLabel)
        contentView.addSubview(bankDistanceLabel)
    }
    
    private func setupConstraints() {
        bankNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.topBottomInsets)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.leadingTrailingInsets)
        }
        
        bankAddressLabel.snp.makeConstraints {
            $0.top.equalTo(bankNameLabel.snp.bottom).offset(Dimensions.topOffsets)
            $0.trailing.leading.equalToSuperview().inset(Dimensions.leadingTrailingInsets)
        }
        
        bankDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(bankAddressLabel.snp.bottom).offset(Dimensions.topOffsets)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.leadingTrailingInsets)
            $0.bottom.equalToSuperview().inset(Dimensions.topBottomInsets)
        }
    }
    
    public func updateWithEntity(bank: SimpleBank) {
        bankNameLabel.text = bank.name
        bankAddressLabel.text = bank.address
        
        if let distance = bank.distance {
            bankDistanceLabel.text = String(format: "%.2f", distance) + " " + "км"
        } else {
            bankDistanceLabel.text = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bankNameLabel.text = nil
        bankAddressLabel.text = nil
        bankDistanceLabel.text = nil
    }
}
