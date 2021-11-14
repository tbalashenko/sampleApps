//
//  TableViewCell.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 25.04.21.
//

import UIKit
import SnapKit

final class AccountTableViewCell: UITableViewCell {
    private enum Dimensions {
        static let sideSpacing = 16
        static let labelHight = 18
        static let labelTopOffset = 8
        static let ibanTopInset = 28
        static let stackBottomInset = 4
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(balanceLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.alignment = .firstBaseline
        stackView.axis = .horizontal
        stackView.spacing = CGFloat(Dimensions.labelTopOffset)
        return stackView
    }()
    
    private lazy var ibanLabel = UILabel(font: UIFont.light(of: 15), textColor: UIColor.Base.black, numberOfLines: 0)
    
    private lazy var accountNameLabel = UILabel(font: UIFont.light(of: 15), textColor: UIColor.Base.black, numberOfLines: 0)
    
    private lazy var balanceLabel = UILabel(font: UIFont.light(of: 44), textColor: UIColor.Base.blue, numberOfLines: 0)
    
    private lazy var currencyLabel = UILabel(font: UIFont.light(of: 15), textColor: UIColor.Base.blue, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.Base.white
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(ibanLabel)
        contentView.addSubview(accountNameLabel)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        ibanLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Dimensions.ibanTopInset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.sideSpacing)
        }
        
        accountNameLabel.snp.makeConstraints {
            $0.top.equalTo(ibanLabel.snp.bottom).offset(Dimensions.labelTopOffset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.sideSpacing)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(accountNameLabel.snp.bottom).offset(Dimensions.labelTopOffset)
            $0.leading.equalToSuperview().inset(Dimensions.sideSpacing)
            $0.trailing.lessThanOrEqualToSuperview().inset(Dimensions.sideSpacing)
            $0.bottom.equalToSuperview().inset(Dimensions.stackBottomInset)
        }
    }
    
    public func updateWithEntity(_ account: Account) {
        ibanLabel.text = account.iban.separate(every: 4, with: " ")
        accountNameLabel.text = account.accountName
        balanceLabel.text = String(account.balance.formattedWithSeparator)
        currencyLabel.text = account.currency
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ibanLabel.text = nil
        accountNameLabel.text = nil
        balanceLabel.text = nil
        currencyLabel.text = nil
    }
}
